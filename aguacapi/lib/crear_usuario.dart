import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';

class CrearUsuario extends StatelessWidget {
  CrearUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              Text(
                'Nueva cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: acBlue,
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Email validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Username validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  // Password validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  // Password confirmation validation logic here
                },
              ),
              SizedBox(height: 16.0),
              Container(
                child: Divider(
                  color: acOrange,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Sexo:',
                style: TextStyle(fontSize: 20.0, color: acBlue),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'male',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Hombre',
                        style: TextStyle(
                            color: Color.fromARGB(255, 63, 63, 63),
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'female',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Mujer',
                        style: TextStyle(
                            color: Color.fromARGB(255, 63, 63, 63),
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'other',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Otro',
                        style: TextStyle(
                            color: Color.fromARGB(255, 63, 63, 63),
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                child: Divider(
                  color: acOrange,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Fecha de nacimiento:',
                    style: TextStyle(color: acBlue, fontSize: 20.0),
                  ),
                  SizedBox(width: 16.0),
                  // TODO:insertar un wdiget de date picker
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                child: Divider(
                  color: acOrange,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Región:',
                    style: TextStyle(color: acBlue, fontSize: 20.0),
                  ),
                  SizedBox(width: 16.0),
                  // TODO: Insertar un dropdown con regiones: fria, templada, calurosa
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                child: Divider(
                  color: acOrange,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Actividad física:',
                    style: TextStyle(color: acBlue, fontSize: 20.0),
                  ),
                  SizedBox(width: 16.0),
                  // TODO: Insertar un dropdown con actividades: alta, media, baja
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Permitir uso de datos para ranking',
                    style: TextStyle(color: acOrange50, fontSize: 16.0),
                  ),
                  SizedBox(width: 16.0),
                  Switch(
                    value: false,
                    onChanged: null,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 31, 70, 109),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Atrás',
                  style: TextStyle(
                    //underline
                    decoration: TextDecoration.underline,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: acOrange50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
