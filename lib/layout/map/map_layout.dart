// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';

class MapLayout extends StatefulWidget {
  const MapLayout({Key? key}) : super(key: key);

  @override
  _MapLayoutState createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {
  late GoogleMapController _mapController;

  late final MapLayoutCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<MapLayoutCubit>(context);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<MapLayoutCubit, MapLayoutState>(
        listener: (context, state) {
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
        child: BlocBuilder<MapLayoutCubit, MapLayoutState>(
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(13.886773726442597, 100.60293697684514),
                    zoom: 22,
                  ),
                  myLocationEnabled: true,
                  mapToolbarEnabled: true,
                  markers: cubit.treasureItems
                      .map(
                        (item) => Marker(
                          markerId: MarkerId(item.id),
                          icon: cubit.treasuries.isEmpty
                              ? BitmapDescriptor.defaultMarker
                              : AssetMapBitmap(
                                  cubit.treasuries.firstWhere((e) => e.id == item.treasureId).imageAsset,
                                  height: 24,
                                ),
                          position: item.latlng,
                          infoWindow: InfoWindow(
                            title: item.treasure(cubit.treasuries)?.name,
                            onTap: () {
                              log("message");
                            },
                          ),
                        ),
                      )
                      .toSet(),
                ),
                Visibility(
                  visible: state is MapLayoutLoading,
                  child: Container(
                    color: Colors.black54,
                    width: double.infinity,
                    height: double.infinity,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
