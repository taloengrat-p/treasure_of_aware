import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/repository/user/user_repository.dart';

part 'user_ranking_state.dart';

class UserRankingCubit extends Cubit<UserRankingState> {
  final _userRepository = GetIt.I<UserRepository>();

  List<Employee> employees = [];
  UserRankingCubit() : super(UserRankingInitial());

  void init() async {
    emit(UserRankingInitialLoading());
    employees = await _userRepository.getAll();
    emit(UserRankingSuccess());
  }

  Future<void> refresh() async {
    emit(UserRankingLoading());
    employees = await _userRepository.getAll();
    emit(UserRankingSuccess());
  }
}
