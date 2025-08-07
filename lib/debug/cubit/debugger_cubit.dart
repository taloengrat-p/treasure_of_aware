import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'debugger_state.dart';

class DebuggerCubit extends Cubit<DebuggerState> {
  DebuggerCubit() : super(DebuggerInitial());
}
