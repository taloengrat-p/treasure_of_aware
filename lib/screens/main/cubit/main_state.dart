// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class MainReset extends MainState {}

class MainUnlockTreasure extends MainState {
  final bool isShowDialog;

  const MainUnlockTreasure(this.isShowDialog);

  @override
  List<Object> get props => [isShowDialog];
}

class MainDetectedCloseToTreasure extends MainState {
  final Treasure treasure;
  final TreasureItem treasureItem;

  const MainDetectedCloseToTreasure({
    required this.treasure,
    required this.treasureItem,
  });

  @override
  List<Object> get props => [treasure.id, treasureItem.id];
}
