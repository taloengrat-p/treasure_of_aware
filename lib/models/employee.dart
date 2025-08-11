// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String id;
  final String name;
  final List<TreasureItem> treasureItem;

  const Employee({
    required this.id,
    required this.name,
    this.treasureItem = const [],
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  int totalPoint(List<Treasure> treasureList) {
    return treasureItem.fold(
      0,
      (accumulate, current) =>
          accumulate +
          (treasureList
                  .where((treasure) => treasure.id == current.treasureId)
                  .firstOrNull
                  ?.point ??
              0),
    );
  }

  Employee copyWith({
    String? id,
    String? name,
    List<TreasureItem>? treasureItem,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      treasureItem: treasureItem ?? this.treasureItem,
    );
  }
}
