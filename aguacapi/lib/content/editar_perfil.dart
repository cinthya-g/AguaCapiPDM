import 'package:aguacapi/providers/configuracion_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:provider/provider.dart';

class EditarPerfil extends StatelessWidget {
  const EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: Color.fromARGB(255, 31, 70, 109),
            margin: EdgeInsets.only(bottom: 5),
            height: 95,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Información de perfil",
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
            margin: EdgeInsets.all(12),
            child: Text('Cambia el o los datos que desees modificar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: Text('Nombre de usuario',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: acOrange50)),
          ),
          SizedBox(height: 10),
          Consumer<ConfiguracionProvider>(
            builder: (context, configProvider, child) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('usuarios-aguacapi')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nuevo nombre de usuario',
                          hintText: '${snapshot.data!.get("username")}',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.person),
                        ),
                        controller: configProvider.newUsername,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
                      ),
                    );
                  });
            },
          ),
          _divider(),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: Text('Sexo',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: acOrange50)),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('usuarios-aguacapi')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                String _sexo = snapshot.data!.get("sex");
                return Container(
                  margin: EdgeInsets.only(
                    left: 30,
                    bottom: 10,
                  ),
                  child: Text('Actual: $_sexo',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: acOrange)),
                );
              }),
          Consumer<ConfiguracionProvider>(
            builder: (context, configProvider, child) {
              return Column(
                // generar 3 radio buttons

                children: configProvider.sexRadioGroupValues.entries
                    .map(
                      (entry) => RadioListTile(
                        title: Text(entry.value),
                        value: entry.key,
                        groupValue: configProvider.sexo,
                        onChanged: (newValue) {
                          configProvider.setSexo(newValue!);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
          _divider(),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: Text('Región',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: acOrange50)),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('usuarios-aguacapi')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                String _region = snapshot.data!.get("region");
                return Container(
                  margin: EdgeInsets.only(
                    left: 30,
                    bottom: 10,
                  ),
                  child: Text('Actual: $_region',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: acOrange)),
                );
              }),
          Consumer<ConfiguracionProvider>(
            builder: (context, configProvider, child) {
              return Column(
                children: configProvider.regionRadioGroupValues.entries
                    .map(
                      (entry) => RadioListTile(
                        title: Text(entry.value),
                        value: entry.key,
                        groupValue: configProvider.region,
                        onChanged: (newValue) {
                          configProvider.setRegion(newValue!);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
          _divider(),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: Text('Actividad física',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: acOrange50)),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('usuarios-aguacapi')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                String _activity = snapshot.data!.get("physicalActivity");
                return Container(
                  margin: EdgeInsets.only(
                    left: 30,
                    bottom: 10,
                  ),
                  child: Text('Actual: $_activity',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: acOrange)),
                );
              }),
          Consumer<ConfiguracionProvider>(
            builder: (context, configProvider, child) {
              return Column(
                // generar 3 radio buttons

                children: configProvider.actividadFisicaRadioGroupValues.entries
                    .map(
                      (entry) => RadioListTile(
                        title: Text(entry.value),
                        value: entry.key,
                        groupValue: configProvider.actividadFisica,
                        onChanged: (newValue) {
                          configProvider.setActividadFisica(newValue!);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
          // Botones de GUARDAR y DESCARTAR
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<ConfiguracionProvider>(
                  builder: (context, configProvider, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (await configProvider.actualizarInformacion()) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar
                            ..showSnackBar(
                              SnackBar(
                                content: Text('Información actualizada'),
                                backgroundColor: acSuccess,
                              ),
                            );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar
                            ..showSnackBar(
                              SnackBar(
                                content: Text('No hay nada que actualizar '),
                                backgroundColor: acOrange50,
                              ),
                            );
                        }
                      },
                      child: Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: acBlue50,
                        foregroundColor: acSurfaceWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Descartar'),
                  style: ElevatedButton.styleFrom(
                    primary: acOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Divider(
        color: acOrange,
        thickness: 1,
      ),
    );
  }
}
