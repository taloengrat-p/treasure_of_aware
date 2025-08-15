import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';
import 'package:treasure_of_aware/repository/user/user_repository.dart';

part 'session_state.dart';

extension SessionContext on BuildContext {
  SessionCubit get session => read<SessionCubit>();
}

class SessionCubit extends Cubit<SessionState> {
  List<Treasure> treasure = [];
  List<TreasureItem> treasureItems = [];

  final _treasureRepository = GetIt.I<TreasureRepository>();
  final _userRepository = GetIt.I<UserRepository>();

  String empId;
  Employee? employee;
  double unlockDistance = 0.5;
  List<TreasureItem> employeeTreasureItem = [];

  SessionCubit({required this.empId}) : super(SessionInitial());

  void init() async {
    emit(SessionInitialLoading());
    employee = await _userRepository.getUserById(empId);
    employeeTreasureItem = await _treasureRepository.getAllItemsByUserId(empId);
    treasure = await _treasureRepository.getAll();
    treasureItems = await _treasureRepository.getAllItems();
    emit(SessionInitialSuccess());
  }

  void refreshEmployee() async {
    emit(SessionInitialLoading());
    employee = await _userRepository.getUserById(empId);
    employeeTreasureItem = await _treasureRepository.getAllItemsByUserId(empId);
    emit(SessionInitialEmployeeSuccess(employeeTreasureItem));
  }

  Treasure? getTreasureById(String id) {
    return treasure.where((e) => e.id == id).firstOrNull;
  }
}
