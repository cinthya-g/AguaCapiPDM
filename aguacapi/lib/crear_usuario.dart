import 'package:aguacapi/home_page.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/providers/crear_usuario_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class CrearUsuario extends StatelessWidget {
  CrearUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CrearUsuarioProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
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
                Column(
                  // generar 3 radio buttons
                  children: context
                      .read<CrearUsuarioProvider>()
                      .firstRadioGroupValues
                      .entries
                      .map(
                        (entry) => RadioListTile(
                          title: Text(entry.value),
                          value: entry.key,
                          groupValue:
                              context.watch<CrearUsuarioProvider>().sexo,
                          onChanged: (newValue) {
                            context
                                .read<CrearUsuarioProvider>()
                                .setSexo(newValue!);
                          },
                        ),
                      )
                      .toList(),
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
                  'Fecha de nacimiento:',
                  style: TextStyle(color: acBlue, fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                TextField(
                    controller: provider.selectedDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Selecciona una fecha',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        provider.selectedDate.text = formattedDate;
                        print(formattedDate);
                        initialDate:
                        formattedDate;
                      } else {
                        print('Date is not selected');
                      }
                    }),
                SizedBox(width: 16.0),
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
                  ],
                ),
                Column(
                  children: context
                      .read<CrearUsuarioProvider>()
                      .secondRadioGroupValues
                      .entries
                      .map(
                        (entry) => RadioListTile(
                          title: Text(entry.value),
                          value: entry.key,
                          groupValue:
                              context.watch<CrearUsuarioProvider>().region,
                          onChanged: (newValue) {
                            context
                                .read<CrearUsuarioProvider>()
                                .setRegion(newValue!);
                          },
                        ),
                      )
                      .toList(),
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
                  ],
                ),
                Column(
                  children: context
                      .read<CrearUsuarioProvider>()
                      .thirdRadioGroupValues
                      .entries
                      .map(
                        (entry) => RadioListTile(
                          title: Text(entry.value),
                          value: entry.key,
                          groupValue: context
                              .watch<CrearUsuarioProvider>()
                              .actividadFisica,
                          onChanged: (newValue) {
                            context
                                .read<CrearUsuarioProvider>()
                                .setActividadFisica(newValue!);
                          },
                        ),
                      )
                      .toList(),
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
                      value:
                          context.watch<CrearUsuarioProvider>().permisoRanking,
                      onChanged: (newValue) {
                        context
                            .read<CrearUsuarioProvider>()
                            .setPermisoRanking(newValue);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
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
        );
      }),
    );
  }
}
