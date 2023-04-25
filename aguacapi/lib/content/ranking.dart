import 'package:flutter/material.dart';
import 'package:aguacapi/content/configuracion.dart';
import 'package:aguacapi/content/home_page.dart';
import 'package:aguacapi/colors/colors.dart';

class Ranking extends StatelessWidget {
  Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: acBlue,
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ranking de usuarios",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Top hidratación",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
                labelText: "Buscar usuario...",
                hintText: "Poncho Carpincho",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)))),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGreen),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 1'),
            subtitle: Text('Consumo: 2200ml'),
            trailing: Text(
              '1º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGreen50),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 2'),
            subtitle: Text('Consumo: 2180ml'),
            trailing: Text(
              '2º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGreen100),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 3'),
            subtitle: Text('Consumo: 2100ml'),
            trailing: Text(
              '3º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGrey),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 4'),
            subtitle: Text('Consumo: 200ml'),
            trailing: Text(
              '4º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGrey),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 5'),
            subtitle: Text('Consumo: 1700ml'),
            trailing: Text(
              '5º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGrey),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 6'),
            subtitle: Text('Consumo: 1600ml'),
            trailing: Text(
              '6º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: acGrey),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            title: Text('Usuario 7'),
            subtitle: Text('Consumo: 200ml'),
            trailing: Text(
              '7º',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
