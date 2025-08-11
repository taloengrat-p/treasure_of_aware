import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  List<TreasureItem> employeeTreasureItem = [];
  List<Treasure> treasureItem = [];

  List<Treasure> get treasureFilteredItem => treasureItem
      .where(
        (e) => employeeTreasureItem.any(
          (empTreasureItems) => empTreasureItems.treasureId == e.id,
        ),
      )
      .map(
        (treasure) => treasure.copyWith(
          amount: employeeTreasureItem
              .where((e) => e.treasureId == treasure.id)
              .length,
        ),
      )
      .toList();
  Employee? employee;

  InventoryCubit({
    this.employee,
    required this.employeeTreasureItem,
    required this.treasureItem,
  }) : super(InventoryInitial());

  void init(List<Treasure> treasure) {}

  void refreshEmployee(List<TreasureItem> empTreasureItems) {
    employeeTreasureItem = empTreasureItems;
    emit(InventoryRefreshEmployeeTreasureItem());
  }
}
