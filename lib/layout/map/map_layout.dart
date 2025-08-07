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
  final cubit = MapLayoutCubit();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MapLayoutCubit, MapLayoutState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
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
                                cubit.treasuries
                                    .firstWhere((e) => e.id == item.treasureId)
                                    .imageAsset,
                                height: 24,
                              ),
                        position: item.latlng,
                        infoWindow: InfoWindow(
                          title: 'Treasure Here!',
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
    );
  }
}
