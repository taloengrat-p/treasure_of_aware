import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:treasure_of_aware/constance/firestore_constance.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

@Singleton(as: TreasureRepository)
class TreasureFirestoreRepository extends TreasureRepository {
  @override
  Future<List<Treasure>> getAll() async {
    try {
      final treasuriesRef = FirebaseFirestore.instance.collection(
        FirestoreConstance.treasure,
      );

      final treasureSnapshot = await treasuriesRef.get();

      final treasuries = treasureSnapshot.docChanges
          .map((e) => Treasure.fromJson(e.doc.data() ?? {}))
          .toList();

      return treasuries;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TreasureItem>> getAllItems() async {
    try {
      final treasuriesRef = FirebaseFirestore.instance.collection(
        FirestoreConstance.treasureItem,
      );

      final treasureItemSnapshot = await treasuriesRef.get();

      final treasuries = treasureItemSnapshot.docChanges
          .map((e) => TreasureItem.fromJson(e.doc.data() ?? {}))
          .toList();

      return treasuries;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TreasureItem>> getAllItemsByUserId(String empId) async {
    try {
      final treasuriesRef = FirebaseFirestore.instance
          .collection(FirestoreConstance.treasureItem)
          .where('owner', isEqualTo: empId);

      final treasureItemSnapshot = await treasuriesRef.get();

      final treasuries = treasureItemSnapshot.docChanges
          .map((e) => TreasureItem.fromJson(e.doc.data() ?? {}))
          .toList();

      return treasuries;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TreasureItem?> claimTreasureItem(String id, Employee emp) async {
    try {
      final treasuriesRef = FirebaseFirestore.instance
          .collection(FirestoreConstance.treasureItem)
          .doc(id);

      final treasureItemSnapshot = await treasuriesRef.get();

      final treasuries = TreasureItem.fromJson(
        treasureItemSnapshot.data() ?? {},
      );

      if (treasuries.owner != null) {
        throw ({"statusCode": 400, "message": "Already has owner"});
      }

      await treasuriesRef.update({"owner": emp.id});

      final claimTreasureItemResult = TreasureItem.fromJson(
        treasureItemSnapshot.data() ?? {},
      );

      return claimTreasureItemResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TreasureItem>> getAllItemsByTreasureId(String id) async {
    try {
      final treasuriesRef = FirebaseFirestore.instance
          .collection(FirestoreConstance.treasureItem)
          .where("treasureId", isEqualTo: id);

      final treasureItemSnapshot = await treasuriesRef.get();

      final treasuries = treasureItemSnapshot.docChanges
          .map((e) => TreasureItem.fromJson(e.doc.data() ?? {}))
          .toList();

      return treasuries;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> resetTreasureItemOwner(String id) async {
    try {
      final treasuriesRef = FirebaseFirestore.instance
          .collection(FirestoreConstance.treasureItem)
          .doc(id);

      final treasureItemSnapshot = await treasuriesRef.get();

      final treasuries = TreasureItem.fromJson(
        treasureItemSnapshot.data() ?? {},
      );

      if (treasuries.owner == null) {
        return;
      }

      await treasuriesRef.update({"owner": null});
    } catch (e) {
      throw Exception(e);
    }
  }
}
