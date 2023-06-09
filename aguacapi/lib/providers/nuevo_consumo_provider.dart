import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:aguacapi/providers/choose_picture_provider.dart';
import 'package:intl/intl.dart';

class NuevoConsumoProvider extends ChangeNotifier {
  static final NuevoConsumoProvider _nuevoConsumoProvider =
      NuevoConsumoProvider._internal();
  factory NuevoConsumoProvider() {
    return _nuevoConsumoProvider;
  }

  NuevoConsumoProvider._internal();

  final ChoosePictureProvider _pictureProvider = ChoosePictureProvider();

  // controllers
  var dateController = TextEditingController();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var drinkPhotoExists = TextEditingController();

  // borrar controllers
  void borrarControllers() {
    dateController.clear();
    quantityController.clear();
    nameController.clear();
    _pictureProvider.borrarImagen();
    notifyListeners();
  }

  // Subir imagen a Storage
  Future<String> _uploadDrinkPhotoToStorage() async {
    // recomendable hacer un try catch por si hay errores de conexión
    try {
      if (_pictureProvider.getPicture == null) return "";
      var _stamp = DateTime.now();
      UploadTask _task = FirebaseStorage.instance
          .ref("drinks-photos-aguacapi/bebida_${_stamp}.png")
          .putFile(_pictureProvider.getPicture!);
      // ejecutar task
      await _task;
      // obtener url de la imagen
      return await _task.storage
          .ref("drinks-photos-aguacapi/bebida_${_stamp}.png")
          .getDownloadURL();
    } catch (e) {
      print("Error al subir archivo a Cloud Storage: ${e.toString()}");
      return "";
    }
  }

  //implementar el guardado de datos en Cloud Firestore
  Future<bool> guardarNuevaBebida(bool esDelMenu) async {
    String imgUrl = "";
    if (!esDelMenu) {
      imgUrl = await _uploadDrinkPhotoToStorage();
    } else {
      // asignar imagen ya existente de la bebida anterior
      imgUrl = drinkPhotoExists.text;
    }
    // crear el objeto mapa con los demás providers
    try {
      if (imgUrl == "") {
        // Bebida default
        imgUrl =
            "https://firebasestorage.googleapis.com/v0/b/auth-example-a3044.appspot.com/o/drinks-photos-aguacapi%2Fdefault.png?alt=media&token=b16de57c-90a6-4303-95ec-22955e4d0895";
      }
      ;

      if (nameController.text == "" ||
          quantityController.text == "" ||
          dateController.text == "") {
        return false;
      }

      double quantityDouble = double.parse(quantityController.text);
      int quantityInt = quantityDouble.roundToDouble().toInt();

      Map<String, dynamic> _data = {
        "idUser": FirebaseAuth.instance.currentUser!.uid,
        "date": dateController.text,
        "name": nameController.text,
        "photo": imgUrl,
        "quantity": quantityInt,
        "repeated": esDelMenu,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      };
      // crear coleccion de cloud firestore
      CollectionReference _drink =
          FirebaseFirestore.instance.collection("bebidas-aguacapi");
      // guardar datos en cloud firestore
      await _drink.add(_data);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error al guardar datos en Cloud Firestore: ${e.toString()}");
      return false;
    }
  }

  // Update de progressGoal
  Future<void> getTodayDrinks() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // Iterar los documentos de las bebidas donde el idUser sea el del usuario
    // y sumar las quantity
    DateTime _fechaHoy = DateTime.now();
    String _formattedDate = DateFormat('dd-MM-yyyy').format(_fechaHoy);
    print("formattedDate: $_formattedDate");
    num _todayDrinks = 0;
    await FirebaseFirestore.instance
        .collection("bebidas-aguacapi")
        .where("idUser", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
        .where("date", isEqualTo: _formattedDate)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _todayDrinks += element["quantity"];
      });
    });
    print(">> Bebidas de hoy: $_todayDrinks");

    // Atualizar el campo goalProgress del usuario con _todayDrinks
    await userDoc.update({"goalProgress": _todayDrinks});
    notifyListeners();
  }

  // Obtener un array con las bebidas que ha creado el usuario
  Future<List> getMyTotalDrinks() async {
    List<QueryDocumentSnapshot> _myDrinks = [];
    DateTime _fechaHoy = DateTime.now();
    String _formattedDate = DateFormat('dd-MM-yyyy').format(_fechaHoy);
    await FirebaseFirestore.instance
        .collection("bebidas-aguacapi")
        .where("idUser", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
        .where("date", isEqualTo: _formattedDate)
        .orderBy("name", descending: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _myDrinks.add(element);
      });
    });
    print(">> Mis bebidas: $_myDrinks");
    return _myDrinks;
  }

  // Borrar la bebida seleccionada
  Future<void> deleteDrink(String idDrink) async {
    await FirebaseFirestore.instance
        .collection("bebidas-aguacapi")
        .doc(idDrink)
        .delete();
    notifyListeners();
  }
}
