part of 'user_ranking_cubit.dart';

sealed class UserRankingState extends Equatable {
  const UserRankingState();

  @override
  List<Object> get props => [];
}

final class UserRankingInitial extends UserRankingState {}

final class UserRankingInitialLoading extends UserRankingState {}

final class UserRankingLoading extends UserRankingState {}

final class UserRankingSuccess extends UserRankingState {}
