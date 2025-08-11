// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'treasure_success_alert_cubit.dart';

sealed class TreasureSuccessAlertState {}

final class TreasureSuccessAlertInitial extends TreasureSuccessAlertState {}

final class TreasureSuccessAlertSuccess extends TreasureSuccessAlertState {}

class TreasureSuccessAlertFailure extends TreasureSuccessAlertState {
  final Object? error;
  TreasureSuccessAlertFailure({this.error});
}

final class TreasureSuccessAlertLoading extends TreasureSuccessAlertState {}
