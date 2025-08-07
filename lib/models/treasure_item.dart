// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part "treasure_item.g.dart";

@JsonSerializable()
class TreasureItem {
  final String id;
  final String location;
  final int direction;
  final double altitude;
  final String? owner;
  final String treasureId;

  TreasureItem({
    required this.id,
    required this.location,
    required this.direction,
    required this.altitude,
    required this.treasureId,
    this.owner,
  });

  factory TreasureItem.fromJson(Map<String, dynamic> json) =>
      _$TreasureItemFromJson(json);

  LatLng get latlng {
    final locationSplit = location.split(",");

    final lat = locationSplit[0];
    final lon = locationSplit[1];

    return LatLng(double.parse(lat), double.parse(lon));
  }

  Map<String, dynamic> toJson() => _$TreasureItemToJson(this);
}
