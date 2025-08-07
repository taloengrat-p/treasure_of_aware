import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'treasure_alert_state.dart';

class TreasureAlertCubit extends Cubit<TreasureAlertState> {
  TreasureAlertCubit() : super(TreasureAlertInitial());
}
