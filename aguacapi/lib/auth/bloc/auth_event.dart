part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class GoogleAuthEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {}

class EmailAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class SelectLoginEvent extends AuthEvent {}

class SelectRegisterEvent extends AuthEvent {}

class BackToHomeEvent extends AuthEvent {}
