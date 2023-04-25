part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  // Mostrar home page
}

class SignOutSuccessState extends AuthState {
  // cerrar sesion
  final String sMsg;
  SignOutSuccessState({this.sMsg = "Sesión cerrada exitosamente"});
}

class AuthErrorState extends AuthState {
  // mosterar un error
  final String eMsg;

  AuthErrorState({this.eMsg = "Error al autenticar"});
  @override
  List<Object> get props => [eMsg];
}

class AuthLoadingState extends AuthState {
  // para mostrar carga
}

class UnAuthState extends AuthState {
  // para mostrar el login
}
