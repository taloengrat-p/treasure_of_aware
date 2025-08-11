import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:treasure_of_aware/constance/firestore_constance.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/repository/user/user_repository.dart';

@Singleton(as: UserRepository)
class UserFirestoreRepository extends UserRepository {
  @override
  Future<List<Employee>> getAll() async {
    try {
      final userRef = FirebaseFirestore.instance.collection(
        FirestoreConstance.user,
      );

      final userSnapshot = await userRef.get();

      final users = userSnapshot.docChanges
          .map(
            (e) => Employee.fromJson({"id": e.doc.id, ...e.doc.data() ?? {}}),
          )
          .toList();

      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Employee?> getUserById(String id) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection(FirestoreConstance.user)
          .doc(id);

      final userSnapshot = await userRef.get();

      final user = Employee.fromJson({
        "id": userSnapshot.id,
        ...userSnapshot.data() ?? {},
      });

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }
}
