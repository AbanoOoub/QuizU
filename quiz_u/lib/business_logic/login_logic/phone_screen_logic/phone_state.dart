part of 'phone_cubit.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class ValidationSuccessState extends PhoneState {}

class ValidationErrorState extends PhoneState {}

class SavePhoneNumberSuccessState extends PhoneState {}

class ValidationLoadingState extends PhoneState {}

class ValidationFailedState extends PhoneState {}

class ChangeHintSuccessState extends PhoneState {}

class ConnectionFailedState extends PhoneState {}
