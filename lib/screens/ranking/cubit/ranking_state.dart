part of 'ranking_cubit.dart';

sealed class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

final class RankingInitial extends RankingState {}

final class RankingLoading extends RankingState {}

final class RankingInitialLoading extends RankingState {}

final class RankingInitialSuccess extends RankingState {}
