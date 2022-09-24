part of 'name_cubit.dart';

@immutable
abstract class NameState {}

class NameInitial extends NameState {}

class PostUserNameSuccessState extends NameState {}

class PostUserNameErrorState extends NameState {}

class PostUserNameLoadingState extends NameState {}

class ConnectionFailedState extends NameState {}
