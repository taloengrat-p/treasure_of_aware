import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

part 'map_layout_state.dart';

class MapLayoutCubit extends Cubit<MapLayoutState> {
  final treasureRepository = GetIt.I<TreasureRepository>();
  LatLng? _currentPosition;
  double? heading;
  double zoom = 22;
  double tilt = 45;
  double accuracy = 0;
  MapLayoutCubit() : super(MapLayoutInitial());

  LatLng? get currentPosition => _currentPosition;

  flyTo(LatLng location) async {
    emit(MapLayoutFlyTo(location));
  }

  void setCurrentPosition(LatLng value, double accuracy) {
    _currentPosition = value;
    this.accuracy = accuracy;
    emitStateUserChange();
  }

  void setCurrentHeading(double? value) {
    heading = value;
    if (_currentPosition == null) {
      return;
    }

    emitStateUserChange();
  }

  void setCurrentZoom(double value) {
    zoom = value;
    emitStateUserChange();
  }

  void setCurrentTilt(double value) {
    tilt = value;
    emitStateUserChange();
  }

  emitStateUserChange() {
    emit(
      MapLayoutUserLocationUpdate(
        location: _currentPosition!,
        heading: (heading ?? 0) >= 360 ? 360 : (heading ?? 0),
        zoom: zoom,
        tilt: tilt,
        accuracy: accuracy,
      ),
    );
  }

  void setAcculacy(double? value) {
    accuracy = value ?? 0;
  }
}
