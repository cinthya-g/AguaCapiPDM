import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/home_page.dart';
import 'package:flutter/services.dart';

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 70,
                              child: CircleAvatar(
                                backgroundColor: Color(0xffE6E6E6),
                                radius: 68,
                                child: Icon(
                                  Icons.person,
                                  size: 65,
                                  color: Color(0xffCCCCCC),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text('Tu meta actual',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: acBrown)),
                            Text('2000ml',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: acOrange)),
                            SizedBox(height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: acOrange,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  fixedSize: const Size(160, 18),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Fijar nueva meta',
                                              style: TextStyle(
                                                  color: acBrown,
                                                  fontSize: 25.0)),
                                          content: SingleChildScrollView(
                                            child: ListBody(children: [
                                              Text(
                                                'Escribe una meta en mililitros',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: acGrey50,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    hintText: '1000'),
                                              ),
                                              SizedBox(height: 16.0),
                                              Text(
                                                'O calcula una nueva con tus datos de perfil',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: acGrey50,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                  child: Text('Calcular meta'),
                                                  onPressed: () {
                                                    // TODO: Calcular meta
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: acBlue,
                                                    onPrimary:
                                                        acBackgroundWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                    ),
                                                  )),
                                            ]),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                child: Text('Guardar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: acBlue50,
                                                  onPrimary: acBackgroundWhite,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32),
                                                  ),
                                                )),
                                            ElevatedButton(
                                              child: Text('Cancelar'),
                                              onPressed: () {
                                                // cerrar dialog
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: acOrange,
                                                onPrimary: acBrown,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 5.0),
                                    Text('Cambiar meta',
                                        style: TextStyle(fontSize: 18))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: acBlue100, borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text('¡Personaliza tu estado!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: acBrown)),
                  subtitle: Text('Registrado desde 01/01/2021'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Escribe un nuevo estado',
                                  style: TextStyle(
                                      color: acBrown, fontSize: 25.0)),
                              content: SingleChildScrollView(
                                child: ListBody(children: [
                                  Text(
                                    'No más de 150 caracteres',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: acGrey50,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Hola, soy Pancho Carpincho'),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(150),
                                      ]),
                                  SizedBox(height: 16.0),
                                ]),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                    child: Text('Guardar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: acBlue50,
                                      onPrimary: acBackgroundWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                    )),
                                ElevatedButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    // cerrar dialog
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: acOrange,
                                    onPrimary: acBrown,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  ),
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
                                  child: Image.asset(
                                      // Aquí siempre se mostrará la última bebida añadida
                                      'assets/images/default.png',
                                      width: 120,
                                      height: 120)),
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
                                    // Modificar este parámetros de acuerdo al 100% de la meta
                                    width: 65,
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
                                  SizedBox(height: 20),
                                  Text(
                                    'Total de hoy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22),
                                  ),
                                  Text(
                                    '1250ml',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 70, 109),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32),
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
