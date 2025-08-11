part of 'treasure_detail_debug_cubit.dart';

sealed class TreasureDetailDebugState extends Equatable {
  const TreasureDetailDebugState();

  @override
  List<Object> get props => [];
}

final class TreasureDetailDebugInitial extends TreasureDetailDebugState {}

final class TreasureDetailDebugLoading extends TreasureDetailDebugState {}

final class TreasureDetailDebugSuccess extends TreasureDetailDebugState {}

final class TreasureDetailDebugFailure extends TreasureDetailDebugState {}
