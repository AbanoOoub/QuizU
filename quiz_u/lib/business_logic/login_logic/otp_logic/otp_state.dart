part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class LoginErrorState extends OtpState {}

class LoginSuccessState extends OtpState {}

class LoginLoadingState extends OtpState {}

class LoginInvalidState extends OtpState {}

class ConnectionFailedState extends OtpState {}
