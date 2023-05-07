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
}
