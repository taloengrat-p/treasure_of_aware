import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treasure_of_aware/constance/firestore_constance.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/repository/user/user_repository.dart';

class UserFirestoreRepository extends UserRepository {
  @override
  Future<List<Employee>> getAll() async {
    try {
      final userRef = FirebaseFirestore.instance.collection(FirestoreConstance.user);

      final userSnapshot = await userRef.get();

      final users = userSnapshot.docChanges.map((e) => Employee.fromJson(e.doc.data() ?? {})).toList();

      return users;
    } catch (e) {
      throw Exception(e);
    }
  }
}
