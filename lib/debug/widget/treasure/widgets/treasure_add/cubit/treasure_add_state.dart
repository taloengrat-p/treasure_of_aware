part of 'treasure_add_cubit.dart';

sealed class TreasureAddState extends Equatable {
  const TreasureAddState();

  @override
  List<Object> get props => [];
}

final class TreasureAddInitial extends TreasureAddState {}

final class TreasureAddLoading extends TreasureAddState {}

final class TreasureAddSuccess extends TreasureAddState {
  final TreasureItem item;
  const TreasureAddSuccess(this.item);
}

final class TreasureAddFailure extends TreasureAddState {}
