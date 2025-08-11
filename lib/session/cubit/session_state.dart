part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class SessionInitial extends SessionState {}

final class SessionInitialLoading extends SessionState {}

final class SessionInitialSuccess extends SessionState {}

final class SessionInitialFailure extends SessionState {}

final class SessionInitialEmployeeSuccess extends SessionState {
  final List<TreasureItem> empTreasureItems;

  const SessionInitialEmployeeSuccess(this.empTreasureItems);
}
