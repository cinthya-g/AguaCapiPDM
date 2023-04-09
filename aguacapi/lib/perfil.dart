import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';

class Perfil extends StatelessWidget {
  Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
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
                      "Perfil de",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "user123",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 60,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE6E6E6),
                      radius: 58,
                      child: Icon(
                        Icons.person,
                        size: 65,
                        color: Color(0xffCCCCCC),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    children: [
                      Text(
                        'Tu meta actual es',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '1900ml',
                        style: TextStyle(
                            color: Color.fromRGBO(243, 163, 110, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            Text('Cambiar meta'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(243, 163, 110, 1),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(171, 198, 253, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text('¡Personaliza tu estado!'),
                  subtitle: Text('Registrado desde 01/01/2021'),
                  trailing: Icon(Icons.edit),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 163, 110, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                    height: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                  child: Icon(Icons.local_drink, size: 110)),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(8, 0, 0, 8),
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(171, 198, 253, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 66, 139, 202),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    'Total de hoy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    '1250ml',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 70, 109),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // TODO: ir a nuevo_consumo.dart
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.add),
                                          Text('Añadir'),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromRGBO(171, 198, 253, 1),
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            )
          ],
        )
      ],
    );
  }
}
