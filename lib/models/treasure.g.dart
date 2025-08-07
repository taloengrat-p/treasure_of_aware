// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treasure _$TreasureFromJson(Map<String, dynamic> json) => Treasure(
  id: json['id'] as String,
  name: json['name'] as String,
  amount: (json['amount'] as num?)?.toInt() ?? 0,
  image: json['image'] as String?,
);

Map<String, dynamic> _$TreasureToJson(Treasure instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'amount': instance.amount,
  'image': instance.image,
};
