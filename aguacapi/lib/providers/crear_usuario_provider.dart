import 'dart:async';
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
}
