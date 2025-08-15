import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';
import 'package:treasure_of_aware/repository/user/user_repository.dart';

part 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _treasureRepository = GetIt.I<TreasureRepository>();

  List<Employee> _employees = [];
  List<TreasureItem> treasureItem = [];

  List<Employee> get employees => _employees
      .map(
        (e) => e.copyWith(
          treasureItem: treasureItem
              .where((item) => item.owner == e.id)
              .toList(),
        ),
      )
      .toList();

  RankingCubit() : super(RankingInitial());

  void init() async {
    emit(RankingInitialLoading());
    _employees = await _userRepository.getAll();
    treasureItem = await _treasureRepository.getAllItems();
    emit(RankingInitialSuccess());
  }

  Future<void> refresh() async {
    emit(RankingLoading());
    _employees = await _userRepository.getAll();
    treasureItem = await _treasureRepository.getAllItems();
    emit(RankingInitialSuccess());
  }

  _doSortRanking() {}
}
