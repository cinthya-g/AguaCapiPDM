import 'package:aguacapi/content/crear_usuario.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/content/login.dart';
import 'package:aguacapi/content/home_page.dart';
import 'package:aguacapi/colors/colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          // logo al centro de la pantalla y dos botones: iniciar sesión y registro
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Image.asset('assets/images/logocircle.png',
                    height: 200, width: 1200, fit: BoxFit.fitHeight),
                SizedBox(height: 5.0),
                Text('AguaCapi', style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 32.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: acBlue50,
                    fixedSize: const Size(200, 50),
                  ),
                  // insertar botón de iniciar sesión con texto e icono
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Inicia sesión',
                      style:
                          TextStyle(fontSize: 20.0, color: acBackgroundWhite)),
                ),
                SizedBox(height: 16.0),
                // insertar linea divisora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      child: Divider(
                        color: acBlue50,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Text(
                        'o',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      width: 90,
                      child: Divider(
                        color: acBlue50,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: acBlue50,
                    fixedSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrearUsuario()),
                    );
                  },
                  child: Text('Crea una cuenta',
                      style:
                          TextStyle(fontSize: 20.0, color: acBackgroundWhite)),
                ),
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //mostrar dialog
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('¿Qué es AguaCapi?',
                        style: TextStyle(color: acBrown, fontSize: 25.0)),
                    content: SingleChildScrollView(
                      child: ListBody(children: [
                        Text(
                          'AguaCapi es una aplicación del tipo "Water Tracker" que te permite llevar un registro de tu consumo de agua y líquidos diario.\nPuedes fijar metas propias o calculadas de acuerdo con tus datos físicos y registrar lo que bebes.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Para poder usar la aplicación debes registrarte, si ya tienes una cuenta puedes iniciar sesión.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ]),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('OK'),
                        onPressed: () {
                          // cerrar dialog
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
          backgroundColor: acOrange,
        ));
  }
}
