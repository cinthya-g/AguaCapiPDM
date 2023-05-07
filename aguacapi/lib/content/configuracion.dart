import 'package:aguacapi/providers/configuracion_provider.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/content/editar_perfil.dart';
import 'package:aguacapi/providers/choose_picture_provider.dart';
import 'package:provider/provider.dart';

class Configuracion extends StatelessWidget {
  Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromARGB(255, 31, 70, 109),
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Configuración",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Editar datos",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(8),
            child: Text('Selecciona el dato a modificar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Información de perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditarPerfil()),
              );
            },
          ),
        ),
        Consumer<ChoosePictureProvider>(builder: (context, provider, _) {
          return _selectImage(provider);
        }),
        Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.key),
            title: Text('Email y contraseña'),
            onTap: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacidad del ranking'),
            onTap: () {},
          ),
        ),
        Consumer<ChoosePictureProvider>(builder: (context, pictureProvider, _) {
          return Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: pictureProvider.getPPicture == null
                ? Container()
                : Row(
                    // dos botones
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer<ConfiguracionProvider>(
                          builder: (context, configProvider, _) {
                        return ElevatedButton(
                            onPressed: () async {
                              if(await configProvider.actualizarFotoPerfil()) {
configProvider.borrarSeleccionFoto();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Foto de perfil actualizada"),
                                            backgroundColor: acSuccess,));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Error al actualizar la foto de perfil"),
                                            backgroundColor: acError,));
                              }
                            },
                            child: Text("Guardar nueva foto"));
                      }),
                      ElevatedButton(onPressed: () {
                          //configProvider.borrarSeleccionFoto();
                      }, child: Text("Cancelar")),
                      
                    ],
                  ),
          );
        }),
      ],
    );
  }

  Widget _selectImage(ChoosePictureProvider prov) {
    return GestureDetector(
      onTap: () {
        prov.choosePictureFromGallery();
      },
      child: prov.getPPicture == null
          ? Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Foto de perfil'),
              ),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
              height: 285,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("Fotografía seleccionada",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  Text("Presiónala para seleccionar otra",
                      style: TextStyle(fontSize: 14)),
                  SizedBox(height: 15),
                  CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 85,
                    backgroundImage:
                        Image.file(prov.getPPicture!, fit: BoxFit.cover).image,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
    );
  }
}
