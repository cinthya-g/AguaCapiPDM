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
          child: Consumer<ConfiguracionProvider>(
            builder: (context, configProvider, child) {
              return ListTile(
                leading: Icon(Icons.contacts),
                title: Text('Información de cáculo de meta y perfil'),
                onTap: () {
                  configProvider.borrarValores();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditarPerfil()),
                  );
                },
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
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacidad del ranking'),
            onTap: () {
              // show dialog
              readOnly:
              true;
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Privacidad del ranking",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: acBlue,
                              fontSize: 24)),
                      content: Text(
                          "El ranking te permite ver tu desempeño en comparación con otros usuarios.\nSi activas esta opción, tu nombre de usuario aparecerá en el ranking.\nSi la desactivas, no aparecerás. Es reversible.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: acBrown)),
                      actions: [
                        Consumer<ConfiguracionProvider>(
                          builder: (context, configProvider, child) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                child: Text('Desactivar'),
                                onPressed: () async {
                                  if (await configProvider
                                      .cambiarRankingPermission(false)) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Ranking desactivado"),
                                      backgroundColor: acOrange,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Error al desactivar el ranking"),
                                      backgroundColor: acError,
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: acBrown,
                                  backgroundColor: acOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Consumer<ConfiguracionProvider>(
                          builder: (context, configProvider, child) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: ElevatedButton(
                                child: Text('Activar'),
                                onPressed: () async {
                                  if (await configProvider
                                      .cambiarRankingPermission(true)) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Ranking activado"),
                                      backgroundColor: acSuccess,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text("Error al activar el ranking"),
                                      backgroundColor: acError,
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: acBackgroundWhite,
                                  backgroundColor: acBlue50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  });
            },
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
                              if (await configProvider.actualizarFotoPerfil()) {
                                configProvider.borrarSeleccionFoto();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Foto de perfil actualizada"),
                                  backgroundColor: acSuccess,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Error al actualizar la foto de perfil"),
                                  backgroundColor: acError,
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: acBlue50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text("Guardar nueva foto"));
                      }),
                      Consumer<ConfiguracionProvider>(
                          builder: (context, configProvider, _) {
                        return ElevatedButton(
                            onPressed: () {
                              configProvider.borrarSeleccionFoto();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text("Cancelar"));
                      }),
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
                title: Text('Cambiar foto de perfil (galería)'),
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
