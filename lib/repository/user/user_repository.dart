import 'package:treasure_of_aware/models/employee.dart';

abstract class UserRepository {
  Future<List<Employee>> getAll();
}
