part of 'leaderboard_cubit.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class GetTopScoresLoadingState extends LeaderboardState {}

class GetTopScoresSuccessState extends LeaderboardState {}

class GetTopScoresErrorState extends LeaderboardState {}

class ConnectionFailedState extends LeaderboardState {}
