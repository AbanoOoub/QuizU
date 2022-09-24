part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserInfoLoadingState extends ProfileState {}

class GetUserInfoSuccessState extends ProfileState {}

class GetUserInfoErrorState extends ProfileState {}

class ConnectionFailedState extends ProfileState {}
