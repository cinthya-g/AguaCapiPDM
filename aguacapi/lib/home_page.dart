import 'package:aguacapi/perfil.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/configuracion.dart';
import 'package:aguacapi/ranking.dart';
import 'package:aguacapi/estadisticas.dart';
import 'package:aguacapi/nuevo_consumo.dart';
import 'package:aguacapi/colors/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
//TODO: Tienen que ir en orden, revisar eso despues
  final _pagesName = [
    "Ranking",
    "Estadisticas",
    "Perfil",
    "NuevoConsumo",
    "Configuracion"
  ];
  final _pagelist = [
    Ranking(),
    Estadisticas(),
    Perfil(),
    NuevoConsumo(),
    Configuracion()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: _pagelist,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: acBlue,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.star_half_sharp,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.analytics_rounded,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
