import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  static final LoginProvider _loginProvider = LoginProvider._internal();
  factory LoginProvider() {
    return _loginProvider;
  }

  LoginProvider._internal();

  // Controllers de mail y contraseña
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Variable de visibilidad de contraseña
  bool passwordVisible = true;

  // Cambiar visibilidad de contraseña
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  // GET de controllers
  String get getEmail => emailController.text;
  String get getPassword => passwordController.text;
}
