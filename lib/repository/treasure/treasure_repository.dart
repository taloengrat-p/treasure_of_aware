import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

abstract class TreasureRepository {
  Future<List<Treasure>> getAll();
  Future<List<TreasureItem>> getAllItems();
  Future<List<TreasureItem>> getAllItemsByTreasureId(String id);
  Future<List<TreasureItem>> getAllItemsByUserId(String empId);
  Future<TreasureItem?> claimTreasureItem(String id, Employee emp);
  Future<void> resetTreasureItemOwner(String id);
}
