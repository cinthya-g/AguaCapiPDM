import 'package:aguacapi/perfil.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/configuracion.dart';
import 'package:aguacapi/ranking.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
//TODO: Tienen que ir en orden, revisar eso despues
  final _pagesName = ["Ranking", "Perfil", "Configuracion"];
  final _pagelist = [Ranking(), Perfil(), Configuracion()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesName[currentIndex]),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: _pagelist,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.star_half_sharp),
            label: '${_pagesName[0]}',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: '${_pagesName[1]}',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: '${_pagesName[2]}',
          ),
        ],
      ),
    );
  }
}
