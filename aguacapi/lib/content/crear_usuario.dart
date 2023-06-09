import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/providers/crear_usuario_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:aguacapi/auth/bloc/auth_bloc.dart';

class CrearUsuario extends StatelessWidget {
  CrearUsuario({super.key});

  String? _email;
  bool _validEmail = false;
  String? _username;
  bool _validUsername = false;
  String? _password;
  bool _validPassword = false;

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
                StatefulBuilder(builder: (context, setState) {
                  return TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _validEmail ? acSuccess : acError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _validEmail ? acSuccess : acError,
                        ),
                      ),
                    ),
                    controller: provider.emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _validEmail = provider
                            .isValidEmail(provider.emailController.text);
                      });
                    },
                  );
                }),
                SizedBox(height: 16.0),
                StatefulBuilder(builder: (context, setState) {
                  return TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      hintText: 'Al menos 5 caracteres',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _validUsername ? acSuccess : acError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _validUsername ? acSuccess : acError,
                        ),
                      ),
                    ),
                    controller: provider.usernameController,
                    maxLength: 15,
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                        _validUsername = provider
                            .isValidUsername(provider.usernameController.text);
                      });
                    },
                  );
                }),
                SizedBox(height: 16.0),
                StatefulBuilder(builder: (context, setState) {
                  return TextFormField(
                    controller: provider.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Al menos 8 caracteres, 1 número y 1 mayúscula',
                      suffixIcon: IconButton(
                          icon: provider.passwordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () => provider.togglePasswordVisibility()),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _validPassword ? acSuccess : acError),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _validPassword ? acSuccess : acError,
                        ),
                      ),
                    ),
                    obscureText: provider.passwordVisible,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        _validPassword = provider
                            .isValidPassword(provider.passwordController.text);
                      });
                    },
                  );
                }),
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
                  children: provider.firstRadioGroupValues.entries
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
                    readOnly: true,
                    controller: provider.selectedDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Selecciona una fecha',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        provider.selectedDate.text = formattedDate;
                      } else {
                        print('Date is not selected');
                      }
                    }),
                SizedBox(width: 16.0),
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
                    BlocProvider.of<AuthBloc>(context).add(LoginAuthEvent());
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
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(BackToHomeEvent());
                  },
                  child: Text('Atrás',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: acOrange50,
                    onPrimary: Colors.white,
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
