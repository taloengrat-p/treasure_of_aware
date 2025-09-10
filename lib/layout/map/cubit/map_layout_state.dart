part of 'map_layout_cubit.dart';

sealed class MapLayoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MapLayoutInitial extends MapLayoutState {}

final class MapLayoutLoading extends MapLayoutState {}

final class MapLayoutFlyTo extends MapLayoutState {
  final LatLng location;

  MapLayoutFlyTo(this.location);
}

final class MapLayoutGetTreasureItemSuccess extends MapLayoutState {}

final class MapLayoutUserLocationUpdate extends MapLayoutState {
  final LatLng location;
  final double heading;
  final double zoom;
  final double tilt;
  final double accuracy;
  final num? altitude;
  MapLayoutUserLocationUpdate({
    required this.location,
    required this.heading,
    required this.zoom,
    required this.tilt,
    required this.accuracy,
    required this.altitude,
  });

  @override
  List<Object?> get props => [
    location.latitude,
    location.longitude,
    heading,
    zoom,
    accuracy,
    tilt,
    altitude,
  ];
}
