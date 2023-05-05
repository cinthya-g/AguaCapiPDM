import 'package:flutter/material.dart';
// Page
import 'package:aguacapi/content/landing_page.dart';
import 'package:aguacapi/content/home_page.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:aguacapi/content/login.dart';
import 'package:aguacapi/content/crear_usuario.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aguacapi/auth/bloc/auth_bloc.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aguacapi/providers/crear_usuario_provider.dart';
import 'package:aguacapi/providers/login_provider.dart';
import 'package:aguacapi/providers/perfil_provider.dart';
import 'package:aguacapi/providers/nuevo_consumo_provider.dart';
import 'package:aguacapi/providers/choose_picture_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // Agregar un MultiProvider
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAuthEvent())),
        ChangeNotifierProvider(
          create: (context) => CrearUsuarioProvider(),
        ),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(
            create: (context) => PerfilProvider()..getTodayDrinks()),
        ChangeNotifierProvider(
            create: (context) => NuevoConsumoProvider()..borrarControllers()),
        ChangeNotifierProvider(create: (context) => ChoosePictureProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AguaCapi App',
        theme: _acTheme,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.eMsg),
                backgroundColor: acError,
              ));
            }
          },
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return HomePage();
            } else if (state is AuthErrorState ||
                state is UnAuthState ||
                state is SignOutSuccessState ||
                state is BackToHomeState) {
              return LandingPage();
            } else if (state is AuthPendingRegisterState ||
                state is AuthErrorRegisterState) {
              return CrearUsuario();
            } else if (state is AuthPendingLoginState ||
                state is AuthErrorLoginState) {
              return LoginPage();
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}

final ThemeData _acTheme = _buildACTheme();
ThemeData _buildACTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: acOrange,
      onPrimary: acBrown,
      secondary: acBlue,
      error: acError,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: acOrange100,
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 60.0,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
      )
      .apply(
        fontFamily: 'Fredoka',
        displayColor: acBlue,
        bodyColor: acBlue50,
      );
}
