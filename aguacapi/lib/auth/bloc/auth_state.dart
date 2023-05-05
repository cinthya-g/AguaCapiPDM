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

class AuthPendingLoginState extends AuthState {
  // mostrar página de login
}

class AuthPendingRegisterState extends AuthState {
  // mostrar página de registro
}

class BackToHomeState extends AuthState {
  // mostrar landing page
}

class SignOutSuccessState extends AuthState {
  // cerrar sesion
  final String sMsg;
  SignOutSuccessState({this.sMsg = "Sesión cerrada exitosamente"});
  @override
  List<Object> get props => [sMsg];
}

class AuthErrorState extends AuthState {
  // mosterar un error
  final String eMsg;

  AuthErrorState({this.eMsg = "Error al autenticar"});
  @override
  List<Object> get props => [eMsg];
}

class AuthErrorLoginState extends AuthState {
  // mostrar login con error
  final String eMsg;

  AuthErrorLoginState({this.eMsg = "Error al iniciar sesión"});
  @override
  List<Object> get props => [eMsg];
}

class AuthErrorRegisterState extends AuthState {
  // mostrar registro con error
  final String eMsg;

  AuthErrorRegisterState({this.eMsg = "Error al registrarse"});
  @override
  List<Object> get props => [eMsg];
}

class AuthLoadingState extends AuthState {
  // para mostrar carga
}

class UnAuthState extends AuthState {
  // para mostrar el login
}
