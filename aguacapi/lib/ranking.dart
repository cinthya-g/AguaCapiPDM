import 'package:flutter/material.dart';
import 'package:aguacapi/configuracion.dart';
import 'package:aguacapi/home_page.dart';

class Ranking extends StatelessWidget {
  Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromARGB(255, 31, 70, 109),
          margin: EdgeInsets.only(bottom: 5),
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
                "Top hidratacion",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
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
              color: Colors.green),
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
              color: Color.fromARGB(255, 97, 224, 34)),
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
              color: Color.fromARGB(255, 158, 225, 35)),
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
              color: Colors.grey),
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
              color: Colors.grey),
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
              color: Colors.grey),
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
              color: Colors.grey),
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
