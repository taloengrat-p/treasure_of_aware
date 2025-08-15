// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasure_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreasureItem _$TreasureItemFromJson(Map<String, dynamic> json) => TreasureItem(
  id: json['id'] as String,
  location: json['location'] as String,
  direction: (json['direction'] as num?)?.toInt(),
  altitude: (json['altitude'] as num).toDouble(),
  treasureId: json['treasureId'] as String,
  owner: json['owner'] as String?,
);

Map<String, dynamic> _$TreasureItemToJson(TreasureItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'direction': instance.direction,
      'altitude': instance.altitude,
      'owner': instance.owner,
      'treasureId': instance.treasureId,
    };
