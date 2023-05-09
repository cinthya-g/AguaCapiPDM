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

  File? _newPPicture;
  File? get getPPicture => _newPPicture;

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
      imageQuality: 70,
    );
    if (_pickedFile != null) {
      _selectedPicture = File(_pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
      return;
    }
  }

  void choosePictureFromGallery() async {
    // Comprobar si el permiso de la galería ha sido concedido
    var galleryStatus = await Permission.photos.status;
    if (!galleryStatus.isGranted) {
      // Si el permiso no ha sido concedido, pedirlo al usuario
      galleryStatus = await Permission.photos.request();
      if (!galleryStatus.isGranted) {
        // Si el usuario rechaza el permiso, salir de la función
        return;
      }
    }

    // Abrir la galería y seleccionar la imagen
    final _pPickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 720,
      maxWidth: 720,
    );
    if (_pPickedFile != null) {
      _newPPicture = File(_pPickedFile.path);
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

  void borrarPPhoto() {
    _newPPicture = null;
    notifyListeners();
  }
}
