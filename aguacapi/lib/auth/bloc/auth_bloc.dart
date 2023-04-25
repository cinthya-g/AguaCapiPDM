import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aguacapi/auth/user_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerification);
    on<GoogleAuthEvent>(_authGoogle);
    on<EmailAuthEvent>(_authEmail);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _authVerification(event, emit) {
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
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
    } catch (e) {
      emit(AuthErrorState(eMsg: "Error con login de Firebase"));
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signOutGoogleUser();
      await _authRepo.signOutFirebaseUser();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(AuthErrorState(eMsg: "Error al cerrar sesión"));
    }
  }
}
