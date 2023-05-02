import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChoosePictureProvider with ChangeNotifier {
  static final ChoosePictureProvider _choosePictureProvider =
      ChoosePictureProvider._internal();
  factory ChoosePictureProvider() {
    return _choosePictureProvider;
  }

  ChoosePictureProvider._internal();

  File? _selectedPicture;
  File? get getPicture => _selectedPicture;

  void choosePictureFromCamera() async {
    // Comprobar si el permiso de la cámara ha sido concedido
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      // Si el permiso no ha sido concedido, pedirlo al usuario
      cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        // Si el usuario rechaza el permiso, salir de la función
        return;
      }
    }

    // Abrir la cámara y seleccionar la imagen
    final _pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 320,
      maxWidth: 320,
      imageQuality: 85,
    );
    if (_pickedFile != null) {
      _selectedPicture = File(_pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
      return;
    }
  }

  void borrarImagen() {
    _selectedPicture = null;
    notifyListeners();
  }
}
