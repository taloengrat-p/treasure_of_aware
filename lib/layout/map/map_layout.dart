// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/debug/cubit/debugger_cubit.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

class MapLayout extends StatefulWidget {
  final MapCreatedCallback? onMapCreated;

  const MapLayout({Key? key, this.onMapCreated}) : super(key: key);

  @override
  _MapLayoutState createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {
  late GoogleMapController _mapController;

  late final MapLayoutCubit maplayoutCubit;
  late final DebuggerCubit debuggerCubit;

  @override
  void initState() {
    maplayoutCubit = BlocProvider.of<MapLayoutCubit>(context);
    debuggerCubit = BlocProvider.of<DebuggerCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapLayoutCubit, MapLayoutState>(
      listener: (context, state) {
        log("state $state", name: runtimeType.toString());
        if (state is MapLayoutFlyTo) {
          Future.delayed(Duration(seconds: 1), () {
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: state.location,
                  zoom: 22, // Adjust zoom level as needed
                  // tilt: 45.0, // Optional: tilt for 3D effect
                  // bearing: 90.0, // Optional: rotate camera to face east, for example
                ),
              ),
              duration: Duration(milliseconds: 750),
            );
          });
        }
      },
      child: Stack(
        children: [
          BlocBuilder<DebuggerCubit, DebuggerState>(
            builder: (context, state) {
              return BlocBuilder<MapLayoutCubit, MapLayoutState>(
                builder: (context, state) {
                  return GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                      if (widget.onMapCreated != null) {
                        widget.onMapCreated!(controller);
                      }
                    },
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    mapToolbarEnabled: false,
                    onCameraMove: (position) {
                      maplayoutCubit.setCurrentZoom(position.zoom);
                    },
                    initialCameraPosition: CameraPosition(
                      target:
                          maplayoutCubit.currentPosition ??
                          LatLng(13.886773726442597, 100.60293697684514),
                      zoom: maplayoutCubit.zoom,
                      tilt: maplayoutCubit.tilt,
                      // bearing: 90,
                    ),
                    onTap: (argument) {
                      if (debuggerCubit.isDebugMode) {
                        maplayoutCubit.setCurrentPosition(argument, 10);
                      }
                    },
                    markers: {
                      if (debuggerCubit.isDebugMode)
                        ...context.session.treasureItems
                            .map(
                              (item) => Marker(
                                markerId: MarkerId("marker-${item.id}"),
                                icon: context.session.treasureItems.isEmpty
                                    ? BitmapDescriptor.defaultMarker
                                    : AssetMapBitmap(
                                        context.session.treasure
                                            .firstWhere(
                                              (e) => e.id == item.treasureId,
                                            )
                                            .imageAsset,
                                        height: 24,
                                      ),
                                position: item.latlng,
                                infoWindow: InfoWindow(
                                  title: item
                                      .treasure(context.session.treasure)
                                      ?.name,
                                  onTap: () {
                                    log("message");
                                  },
                                ),
                              ),
                            )
                            .toSet(),
                      if (maplayoutCubit.currentPosition != null)
                        Marker(
                          markerId: MarkerId("current-location"),
                          icon: AssetMapBitmap(
                            "assets/images/navigator.png",
                            height: 20,
                          ),
                          flat: true,
                          position: maplayoutCubit.currentPosition!,
                          rotation: maplayoutCubit.heading ?? 0,
                        ),
                    },
                    circles: {
                      if (debuggerCubit.isDebugMode)
                        ...context.session.treasureItems
                            .map(
                              (item) => Circle(
                                circleId: CircleId('${item.id}-radius'),
                                center: item.latlng,
                                radius: 1, // meters
                                strokeWidth: 2,
                                strokeColor: Colors.blue.withOpacity(0.5),
                                fillColor: Colors.blue.withOpacity(0.2),
                              ),
                            )
                            .toSet(),
                    },
                  );
                },
              );
            },
          ),
          BlocBuilder<MapLayoutCubit, MapLayoutState>(
            builder: (BuildContext context, MapLayoutState state) {
              return Visibility(
                visible: state is MapLayoutLoading,
                child: Container(
                  color: Colors.black54,
                  width: double.infinity,
                  height: double.infinity,
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
          BlocBuilder<DebuggerCubit, DebuggerState>(
            builder: (context, state) {
              return Visibility(
                visible: debuggerCubit.isDebugMode,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      color: Colors.black38,
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.all(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "location: ${maplayoutCubit.currentPosition}\nleading: ${maplayoutCubit.heading}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
