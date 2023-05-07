import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CrearUsuarioProvider with ChangeNotifier {
  static final CrearUsuarioProvider _crearUsuarioProvider =
      CrearUsuarioProvider._internal();
  factory CrearUsuarioProvider() {
    return _crearUsuarioProvider;
  }

  CrearUsuarioProvider._internal();

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordVisible = true;
  var selectedDate = TextEditingController();

// Cambiar visibilidad de contraseña
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

// RadioButtons de sexo
  var firstRadioGroupValues = {
    0: 'Hombre',
    1: 'Mujer',
    2: 'Otro',
  };
  int sexo = 0;

  // RadioButtons de región
  var secondRadioGroupValues = {
    0: 'Fría',
    1: 'Templada',
    2: 'Calurosa',
  };
  int region = 0;

  // RadioButtons de actividad física
  var thirdRadioGroupValues = {
    0: 'Baja',
    1: 'Media',
    2: 'Alta',
  };
  int actividadFisica = 0;

  // GET de controllers
  String get getEmail => emailController.text;
  String get getUsername => usernameController.text;
  String get getPassword => passwordController.text;
  String get getSelectedDate => selectedDate.text;
  String? get getSex => firstRadioGroupValues[sexo];
  String? get getRegion => secondRadioGroupValues[region];
  String? get getActividadFisica => thirdRadioGroupValues[actividadFisica];
  bool get getPermisoRanking => permisoRanking;

  // Permiso de ranking
  bool permisoRanking = true;

  void setSexo(int value) {
    sexo = value;
    notifyListeners();
    print('Sexo: ${sexo}');
  }

  void setRegion(int value) {
    region = value;
    notifyListeners();
    print('Region: ${region}');
  }

  void setActividadFisica(int value) {
    actividadFisica = value;
    notifyListeners();
    print('Actividad Física: ${actividadFisica}');
  }

  void setPermisoRanking(bool value) {
    permisoRanking = value;
    notifyListeners();
    print('Permiso de ranking: ${permisoRanking}');
  }

  // Set de todos los controllers
  void setControllers(
      String email, String username, String password, String selectedDate) {
    emailController.text = email;
    print('Email: ${emailController.text}');
    usernameController.text = username;
    print('Username: ${usernameController.text}');
    passwordController.text = password;
    print('Password: ${passwordController.text}');
    selectedDate = selectedDate;
    notifyListeners();
  }

  void borrarFormularioCrear() {
    emailController.clear();
    usernameController.clear();
    passwordController.clear();
    selectedDate.clear();
    sexo = 0;
    region = 0;
    actividadFisica = 0;
    permisoRanking = true;
    notifyListeners();
  }

  // Validaciones
  bool isValidForm() {
    if (getEmail.isEmpty ||
        getUsername.isEmpty ||
        getPassword.isEmpty ||
        getSelectedDate.isEmpty ||
        !isValidEmail(emailController.text)) {
      return false;
    }
    return true;
  }

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String pass) {
    final passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    print("pass: ${passRegex.hasMatch(pass)}");
    return passRegex.hasMatch(pass);
  }

// Usernam de al menos 5 caracteres
  bool isValidUsername(String username) {
    if (username.length < 5) {
      print("length es de ${username.length}");
      return false;
    }
    return true;
  }
}
