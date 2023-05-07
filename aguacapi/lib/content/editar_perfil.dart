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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          labelText: 'Nombre de usuario',
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
          _divider()
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        color: acOrange,
        thickness: 1,
      ),
    );
  }
}
