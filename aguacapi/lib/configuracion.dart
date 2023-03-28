import 'package:flutter/material.dart';
import 'package:aguacapi/home_page.dart';
import 'package:aguacapi/ranking.dart';

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
                  "Configuracion",
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
            title: Text('Informacion de perfil'),
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
            leading: Icon(Icons.camera_alt),
            title: Text('Foto de perfil'),
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
      ],
    );
  }
}
