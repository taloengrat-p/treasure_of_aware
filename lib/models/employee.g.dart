// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  id: json['id'] as String,
  name: json['name'] as String,
  treasureItem:
      (json['treasureItem'] as List<dynamic>?)
          ?.map((e) => TreasureItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'treasureItem': instance.treasureItem,
};
