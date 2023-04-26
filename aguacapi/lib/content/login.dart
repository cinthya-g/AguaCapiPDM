import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/content/home_page.dart';
import 'package:aguacapi/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aguacapi/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<LoginProvider>(builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50.0),
                  Text("Iniciar sesión",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                          color: acBlue)),
                  SizedBox(height: 32.0),
                  TextField(
                    controller: provider.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextField(
                    controller: provider.passwordController,
                    obscureText: provider.passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(provider.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: provider.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(EmailAuthEvent());
                      BlocProvider.of<AuthBloc>(context).add(VerifyAuthEvent());
                    },
                    child: Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      primary: acBlue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text('Entrar con Google'),
                    style: ElevatedButton.styleFrom(
                      primary: acBlue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          );
        }));
  }
}
