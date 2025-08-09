part of 'map_layout_cubit.dart';

sealed class MapLayoutState {}

final class MapLayoutInitial extends MapLayoutState {}

final class MapLayoutLoading extends MapLayoutState {}

final class MapLayoutFlyTo extends MapLayoutState {
  final LatLng location;

  MapLayoutFlyTo(this.location);
}

final class MapLayoutGetTreasureItemSuccess extends MapLayoutState {}
