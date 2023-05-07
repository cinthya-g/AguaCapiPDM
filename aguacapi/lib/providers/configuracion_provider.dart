import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aguacapi/providers/choose_picture_provider.dart';

class ConfiguracionProvider with ChangeNotifier {
  static final ConfiguracionProvider _configuracionProvider =
      ConfiguracionProvider._internal();
  factory ConfiguracionProvider() {
    return _configuracionProvider;
  }

  ConfiguracionProvider._internal();

  final ChoosePictureProvider _pictureProvider = ChoosePictureProvider();

  // Subir imagen de perfil a Storage
  Future<String> _uploadProfilePhotoToStorage() async {
    try {
      if (_pictureProvider.getPPicture == null) return "";
      var _stamp = DateTime.now();
      UploadTask _task = FirebaseStorage.instance
          .ref(
              "photos-aguacapi/pp_${FirebaseAuth.instance.currentUser!.uid}_${_stamp}.png")
          .putFile(_pictureProvider.getPPicture!);
      // ejecutar task
      await _task;
      // obtener url de la imagen
      return await _task.storage
          .ref(
              "photos-aguacapi/pp_${FirebaseAuth.instance.currentUser!.uid}_${_stamp}.png")
          .getDownloadURL();
    } catch (e) {
      print("Error al subir archivo a Cloud Storage: ${e.toString()}");
      return "";
    }
  }

  // Actualizar la foto de perfil del usuario
  Future<bool> actualizarFotoPerfil() async {
    String imgUrl = await _uploadProfilePhotoToStorage();
    if (imgUrl == "") {
      imgUrl =
          "https://firebasestorage.googleapis.com/v0/b/auth-example-a3044.appspot.com/o/photos-aguacapi%2FdefaultProfile.png?alt=media&token=2b8453b1-02b7-49d4-b189-1d2cb1cdd3f3";
    }
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await userDoc.update({"profilePhoto": imgUrl});

    return true;
  }

  void borrarSeleccionFoto() {
    _pictureProvider.borrarPPhoto();
    notifyListeners();
  }

  // ---- EDICION DEL PERFIL -----
  // Controllers
  var newUsername = TextEditingController();
  // Si es -1 es que no lo cambió
  int sexo = -1;
  int actividadFisica = -1;
  int region = -1;

  var sexRadioGroupValues = {
    0: 'Hombre',
    1: 'Mujer',
    2: 'Otro',
  };

  var regionRadioGroupValues = {
    0: 'Fría',
    1: 'Templada',
    2: 'Calurosa',
  };

  var actividadFisicaRadioGroupValues = {
    0: 'Baja',
    1: 'Media',
    2: 'Alta',
  };

  setSexo(int value) {
    sexo = value;
    notifyListeners();
  }

  setActividadFisica(int value) {
    actividadFisica = value;
    notifyListeners();
  }

  setRegion(int value) {
    region = value;
    notifyListeners();
  }

  // Borrar valores
  void borrarValores() {
    newUsername.text = "";
    sexo = -1;
    actividadFisica = -1;
    region = -1;
    notifyListeners();
  }

  // Guardar cambios en el documento del usuario
  Future<bool> actualizarInformacion() async {
    // Sí cambió el username
    if (newUsername.text != "") {
      var userDoc = await FirebaseFirestore.instance
          .collection("usuarios-aguacapi")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc.update({"username": newUsername.text});
    }
    // Sí cambio la variable "sexo"
    if (sexo != -1) {
      String _newSex = '';
      if (sexo == 0)
        _newSex = 'Hombre';
      else if (sexo == 1)
        _newSex = 'Mujer';
      else if (sexo == 2) _newSex = 'Otro';
      var userDoc = await FirebaseFirestore.instance
          .collection("usuarios-aguacapi")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc.update({"sex": _newSex});
    }

    // Sí cambió la variable "region"
    if (region != -1) {
      String _newRegion = '';
      if (region == 0)
        _newRegion = 'Fría';
      else if (region == 1)
        _newRegion = 'Templada';
      else if (region == 2) _newRegion = 'Calurosa';
      var userDoc = await FirebaseFirestore.instance
          .collection("usuarios-aguacapi")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc.update({"region": _newRegion});
    }

    // Sí cambió la variable "actividadFisica"
    if (actividadFisica != -1) {
      String _newActividadFisica = '';
      if (actividadFisica == 0)
        _newActividadFisica = 'Baja';
      else if (actividadFisica == 1)
        _newActividadFisica = 'Media';
      else if (actividadFisica == 2) _newActividadFisica = 'Alta';
      var userDoc = await FirebaseFirestore.instance
          .collection("usuarios-aguacapi")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc.update({"physicalActivity": _newActividadFisica});
    }

    if (newUsername.text != "" ||
        sexo != -1 ||
        region != -1 ||
        actividadFisica != -1)
      return true;
    else
      return false;
  }

  // Cambiar rankingPermission
  Future<bool> cambiarRankingPermission(bool value) async {
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await userDoc.update({"rankingPermission": value});
    return true;
  }
}
