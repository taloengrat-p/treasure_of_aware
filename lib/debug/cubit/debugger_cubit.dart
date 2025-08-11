import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'debugger_state.dart';

class DebuggerCubit extends Cubit<DebuggerState> {
  bool isDebugMode = false;

  DebuggerCubit() : super(DebuggerInitial());

  toggleDebugMode() {
    isDebugMode = !isDebugMode;
    emit(DebuggerChangeDebugMode(isDebugMode: isDebugMode));
  }
}
