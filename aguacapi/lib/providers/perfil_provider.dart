import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilProvider with ChangeNotifier {
  static final PerfilProvider _perfilProvider = PerfilProvider._internal();
  factory PerfilProvider() {
    return _perfilProvider;
  }

  PerfilProvider._internal();

  // ID de usuario autenticado
  String _uid = "${FirebaseAuth.instance.currentUser!.uid}";

  Future<DocumentSnapshot> getMyContent() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    print(
        "Entró a obtener contenido de: ${FirebaseAuth.instance.currentUser!.uid}");
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");
    // Query para sacar la data del documento
    var userContent = await userDoc.get();
    final _userContentData = userContent.data()!;
    print(">> Contenido del usuario: $_userContentData");

    return userContent;
  }

  // controller de la nueva meta
  var newGoalController = TextEditingController();

  // editar el atributo de goal en el documento del usuario
  Future<void> editGoal() async {
    double _doubleGoal = double.parse(newGoalController.text);
    int _intGoal = _doubleGoal.roundToDouble().toInt();

    if (_intGoal > 7000) {
      _intGoal = 7000;
    } else if (_intGoal < 1500) {
      _intGoal = 1500;
    }
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // Actualizar la meta del usuario
    await userDoc.update({"goal": _intGoal});
    print(">> Meta actualizada: ${newGoalController.text}");
    notifyListeners();
  }

  // borrar controller de dialog
  void borrarDialogMeta() {
    newGoalController.clear();
    notifyListeners();
  }

  // calcular nueva meta de acuerdo con datos de usuario
  Future<void> calcularMeta() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // Query para sacar la data del documento
    var userContent = await userDoc.get();
    final _userContentData = userContent.data()!;

    // Calcular meta
    int _meta = 0;
    if (_userContentData["sexo"] == "Hombre") {
      _meta = 2000;
    } else if (_userContentData["sexo"] == "Mujer") {
      _meta = 1900;
    } else {
      _meta = 1800;
    }

    if (_userContentData["physicalActivity"] == "Alta") {
      _meta += 500;
    } else if (_userContentData["physicalActivity"] == "Media") {
      _meta += 300;
    } else if (_userContentData["physicalActivity"] == "Baja") {
      _meta += 100;
    }

    if (_userContentData["region"] == "Calurosa") {
      _meta += 300;
    } else if (_userContentData["region"] == "Templada") {
      _meta += 100;
    } else if (_userContentData["region"] == "Fría") {
      _meta += 0;
    }

    // Actualizar la meta del usuario
    await userDoc.update({"goal": _meta});
    notifyListeners();
  }

  // controller de nuevo estado
  var newStatusController = TextEditingController();

  // editar el atributo de estado en el documento del usuario
  Future<void> editStatus() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // Actualizar el estado del usuario
    await userDoc.update({
      "status": newStatusController.text,
    });
    print(">> Estado actualizado: ${newStatusController.text}");
    notifyListeners();
  }

  // borrar controller de dialog
  void borrarDialogEstado() {
    newStatusController.clear();
    notifyListeners();
  }

  // obtener el porcentaje de avance entre progressGoal y goal
  Future<double> getProgress() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // Query para sacar la data del documento
    var userContent = await userDoc.get();
    final _userContentData = userContent.data()!;

    // Calcular porcentaje
    double progressDouble = 0;
    return progressDouble =
        (_userContentData["progressGoal"] / _userContentData["goal"]) * 100;
  }
}
