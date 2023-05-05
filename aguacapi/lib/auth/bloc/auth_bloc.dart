import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aguacapi/auth/user_auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerification);
    on<GoogleAuthEvent>(_authGoogle);
    on<EmailAuthEvent>(_authEmail);
    on<LoginAuthEvent>(_createAuthEmail);
    on<SignOutEvent>(_signOut);
    on<SelectLoginEvent>(_loginForm);
    on<SelectRegisterEvent>(_registerForm);
    on<BackToHomeEvent>(_backToHome);
  }

  FutureOr<void> _authVerification(event, emit) {
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
      print("STATE: AuthSuccessState");
    } else {
      emit(UnAuthState());
      print("STATE: UnAuthState");
    }
  }

  FutureOr<void> _authGoogle(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(eMsg: "Error con login de Google"));
    }
  }

  FutureOr<void> _authEmail(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signInWithFirebase();
      emit(AuthSuccessState());
      print("STATE: AuthSuccessState");
    } catch (e) {
      emit(AuthErrorLoginState(eMsg: "Verifique datos de inicio de sesión"));
      print("STATE: AuthErrorLoginState");
    }
  }

  FutureOr<void> _createAuthEmail(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.createAccount();
      await _authRepo.createUserDocument();
      emit(AuthSuccessState());
      print("STATE: AuthSuccessState");
    } catch (e) {
      emit(AuthErrorRegisterState(eMsg: "Verifique datos de registro"));
      print("STATE: AuthErrorRegisterState");
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signOutGoogleUser();
      await _authRepo.signOutFirebaseUser();
      emit(SignOutSuccessState(sMsg: "Sesión cerrada exitosamente"));
      print("STATE: SignOutSuccessState - SESIÓN CERRADA!");
    } catch (e) {
      emit(AuthErrorState(eMsg: "Error al cerrar sesión"));
      print("STATE: AuthErrorState - al cerrar sesion");
    }
  }

// Hacer futures de register y loginform que muestre las pantallas (evitar push)
  FutureOr<void> _registerForm(event, emit) async {
    emit(AuthLoadingState());
    emit(AuthPendingRegisterState());
  }

  FutureOr<void> _loginForm(event, emit) async {
    emit(AuthLoadingState());
    emit(AuthPendingLoginState());
  }

  FutureOr<void> _backToHome(event, emit) async {
    emit(AuthLoadingState());
    emit(BackToHomeState());
  }
}
