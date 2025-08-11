part of 'debugger_cubit.dart';

sealed class DebuggerState extends Equatable {}

final class DebuggerInitial extends DebuggerState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class DebuggerChangeDebugMode extends DebuggerState {
  final bool isDebugMode;

  DebuggerChangeDebugMode({this.isDebugMode = false});

  @override
  List<Object?> get props => [isDebugMode];
}
