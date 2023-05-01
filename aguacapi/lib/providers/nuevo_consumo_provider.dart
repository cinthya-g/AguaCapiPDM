import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NuevoConsumoProvider extends ChangeNotifier {
  static final NuevoConsumoProvider _nuevoConsumoProvider =
      NuevoConsumoProvider._internal();
  factory NuevoConsumoProvider() {
    return _nuevoConsumoProvider;
  }

  NuevoConsumoProvider._internal();

  // controllers
  var dateController = TextEditingController();
  var quantityController = TextEditingController();

  // borrar controllers
  void borrarControllers() {
    dateController.clear();
    quantityController.clear();
    notifyListeners();
  }
}
