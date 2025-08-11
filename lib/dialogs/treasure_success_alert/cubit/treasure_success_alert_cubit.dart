import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:treasure_of_aware/models/employee.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

part 'treasure_success_alert_state.dart';

class TreasureSuccessAlertCubit extends Cubit<TreasureSuccessAlertState> {
  final _treasureRepository = GetIt.I<TreasureRepository>();
  TreasureSuccessAlertCubit() : super(TreasureSuccessAlertInitial());

  void submit(String id, Employee? emp) async {
    if (emp != null) {
      try {
        emit(TreasureSuccessAlertLoading());
        await _treasureRepository.claimTreasureItem(id, emp);
        emit(TreasureSuccessAlertSuccess());
      } catch (e) {
        emit(TreasureSuccessAlertFailure(error: e));
      }
    }
  }
}
