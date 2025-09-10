import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/debug/cubit/debugger_cubit.dart';
import 'package:treasure_of_aware/debug/debugger_button_widget.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/layout/map/map_layout.dart';
import 'package:treasure_of_aware/screens/inventory/inventory_screen.dart';
import 'package:treasure_of_aware/screens/main/cubit/main_cubit.dart';
import 'package:treasure_of_aware/screens/ranking/ranking_screen.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';
import 'package:treasure_of_aware/widgets/dialogs/treasure_success_alert/treasure_success_alert.dart';
import 'package:treasure_of_aware/widgets/overlay_loading.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainCubit cubit;
  late final MapLayoutCubit mapCubit;
  late final DebuggerCubit debuggerCubit;
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;
  StreamSubscription<CompassEvent>? _compassSubscription;

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  @override
  void dispose() {
    _positionStream?.cancel();
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mapCubit = BlocProvider.of<MapLayoutCubit>(context);
    cubit = MainCubit(mapLayoutCubit: mapCubit, sessionCubit: context.session);
    debuggerCubit = BlocProvider.of<DebuggerCubit>(context);

    Geolocator.getPositionStream().listen((Position position) {
      if (!debuggerCubit.isDebugMode) {
        mapCubit.setCurrentPosition(
          LatLng(position.latitude, position.longitude),
          position.accuracy,
          altitude: position.altitude,
        );
      }
    });

    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (!debuggerCubit.isDebugMode) {
        if (event.heading != null) {
          // Example: Unlock condition if facing north
          mapCubit.setCurrentHeading(event.heading);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<MapLayoutCubit, MapLayoutState>(
            listener: (context, state) =>
                handleListenerMapLayoutState(context, state),
          ),
          BlocListener<MainCubit, MainState>(
            listener: (context, state) =>
                handleListenerMainState(context, state),
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: [
              MapLayout(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 16, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          heroTag: "ranking",
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RankingScreen(showBottom: false),
                              ),
                            );
                          },
                          splashColor: Colors.red,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.star_rate_rounded,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(height: 8),
                        FloatingActionButton(
                          heroTag: "inventory",
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const InventoryScreen(),
                              ),
                            );
                          },
                          splashColor: Colors.red,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.inventory_2_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocSelector<MapLayoutCubit, MapLayoutState, double>(
                selector: (state) {
                  return state is MapLayoutUserLocationUpdate
                      ? state.accuracy
                      : 0;
                },
                builder: (context, accuracy) {
                  if (accuracy <= context.session.accuracyTarget) {
                    return SizedBox();
                  }

                  return OverlayLoading(
                    message:
                        "Accuracy : $accuracy\n Should be less than or equal to ${context.session.accuracyTarget}",
                  );
                },
              ),
              DebuggerButtonWidget(),
              // SafeArea(
              //   child: Align(
              //     alignment: Alignment.bottomLeft,
              //     child: FloatingActionButton(
              //       onPressed: () {
              //         TreasureSuccessAlert.show(context);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void handleListenerMapLayoutState(
    BuildContext context,
    MapLayoutState state,
  ) {
    if (state is MapLayoutUserLocationUpdate) {
      // if (!debuggerCubit.isDebugMode) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: mapCubit.currentPosition!,
            zoom: state.zoom,
            bearing: state.heading,
            tilt: state.tilt,
          ),
        ),
      );

      cubit.detectCloseToTreasureItem();
      // }
    }
  }

  void handleListenerMainState(BuildContext context, MainState state) async {
    if (state is MainDetectedCloseToTreasure) {
      if (cubit.isShowUnlockTreasure) {
        return;
      }

      cubit.doShowUnlockTreasureItem();

      await TreasureSuccessAlert.show(
        context,
        treasure: state.treasure,
        treasureItem: state.treasureItem,
      );

      cubit.doHideUnlockTreasureItem();
    }
  }
}
