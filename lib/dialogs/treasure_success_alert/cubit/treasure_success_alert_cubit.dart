import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'treasure_success_alert_state.dart';

class TreasureSuccessAlertCubit extends Cubit<TreasureSuccessAlertState> {
  TreasureSuccessAlertCubit() : super(TreasureSuccessAlertInitial());
}
