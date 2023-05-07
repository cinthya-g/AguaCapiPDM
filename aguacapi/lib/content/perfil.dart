import 'package:aguacapi/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:aguacapi/providers/perfil_provider.dart';
import 'package:aguacapi/providers/nuevo_consumo_provider.dart';

import '../widgets/weatherWidget.dart';

class Perfil extends StatelessWidget {
  Perfil({super.key});

  //#######################################################################
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
//#######################################################################

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
                    Consumer<PerfilProvider>(
                      builder: (context, perfilProvider, child) {
                        return FutureBuilder(
                          future: perfilProvider.getMyContent(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(
                                "${snapshot.data!.get("username")}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            } else {
                              return Text(
                                "Cargando...",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }
                          },
                        );
                      },
                    ),
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
                            Consumer<PerfilProvider>(
                              builder: (context, perfilProvider, child) {
                                return FutureBuilder(
                                  future: perfilProvider.getMyContent(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 70,
                                        child: CircleAvatar(
                                          backgroundColor: Color(0xffE6E6E6),
                                          radius: 68,
                                          backgroundImage: Image.network(
                                                  "${snapshot.data!.get("profilePhoto")}")
                                              .image,
                                        ),
                                      );
                                    } else {
                                      return CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 70,
                                        child: CircleAvatar(
                                          backgroundColor: Color(0xffE6E6E6),
                                          radius: 68,
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: acBrown)),
                            Consumer<PerfilProvider>(
                              builder: (context, perfilProvider, child) {
                                return FutureBuilder(
                                  future: perfilProvider.getMyContent(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text(
                                        "${snapshot.data!.get("goal")} ml",
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: acBlue),
                                      );
                                    } else {
                                      return Text(
                                        "...",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: acOrange,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  fixedSize: const Size(160, 20),
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
                                              Consumer<PerfilProvider>(builder:
                                                  ((context, provider, _) {
                                                return TextField(
                                                  controller: provider
                                                      .newGoalController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText: '1000'),
                                                );
                                              })),
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
                                              Consumer<PerfilProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return ElevatedButton(
                                                      child:
                                                          Text('Calcular meta'),
                                                      onPressed: () async {
                                                        await provider
                                                            .calcularMeta();
                                                        provider
                                                            .borrarDialogMeta();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Meta calculada y actualizada'),
                                                          duration: Duration(
                                                              seconds: 3),
                                                        ));
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: acBlue,
                                                        onPrimary:
                                                            acBackgroundWhite,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(32),
                                                        ),
                                                      ));
                                                },
                                              ),
                                            ]),
                                          ),
                                          actions: <Widget>[
                                            Consumer<PerfilProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return ElevatedButton(
                                                    child: Text('Guardar'),
                                                    onPressed: () async {
                                                      await provider.editGoal();
                                                      provider
                                                          .borrarDialogMeta();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            'Meta actualizada'),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ));

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: acBlue50,
                                                      onPrimary:
                                                          acBackgroundWhite,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                    ));
                                              },
                                            ),
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
                                        style: TextStyle(fontSize: 16))
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
                  title: Consumer<PerfilProvider>(
                    builder: (context, perfilProvider, _) {
                      return FutureBuilder(
                        future: perfilProvider.getMyContent(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text("${snapshot.data!.get("status")}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: acBrown));
                          } else {
                            return Text('...',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: acBrown));
                          }
                        },
                      );
                    },
                  ),
                  subtitle: Consumer<PerfilProvider>(
                    builder: (context, perfilProvider, child) {
                      return FutureBuilder(
                        future: perfilProvider.getMyContent(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text(
                              "Registrado desde ${snapshot.data!.get("createdAt")}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            );
                          } else {
                            return Text(
                              "...",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }
                        },
                      );
                    },
                  ),
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
                                  Consumer<PerfilProvider>(
                                      builder: (context, provider, _) {
                                    return TextFormField(
                                        maxLength: 150,
                                        controller:
                                            provider.newStatusController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'Inspírate'),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(150),
                                        ]);
                                  }),
                                  SizedBox(height: 16.0),
                                ]),
                              ),
                              actions: <Widget>[
                                Consumer<PerfilProvider>(
                                    builder: (context, provider, _) {
                                  return ElevatedButton(
                                      child: Text('Guardar'),
                                      onPressed: () async {
                                        await provider.editStatus();
                                        provider.borrarDialogEstado();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Estado actualizado')));
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: acBlue50,
                                        onPrimary: acBackgroundWhite,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                      ));
                                }),
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
            Container(
                child: Obx(
              () => globalController.checkloading().isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : WeatherWidget(
                      weatherDataDaily:
                          globalController.getData().getDailyWeather()),
            )),
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
                              height: 12,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(171, 198, 253, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Consumer<PerfilProvider>(
                                    builder: (context, perfilProvider, child) {
                                      return FutureBuilder(
                                        future: perfilProvider.getMyContent(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Container(
                                              // Modificar este parámetros de acuerdo al 100% de la meta
                                              width: ((snapshot.data!.get(
                                                                      "goalProgress") /
                                                                  snapshot.data!
                                                                      .get(
                                                                          "goal")) *
                                                              100)
                                                          .roundToDouble() >=
                                                      100
                                                  ? 100
                                                  : ((snapshot.data!.get(
                                                              "goalProgress") /
                                                          snapshot.data!
                                                              .get("goal")) *
                                                      100),
                                              height: 12,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 66, 139, 202),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            );
                                          } else {
                                            return Container(
                                              // Modificar este parámetros de acuerdo al 100% de la meta
                                              width: 0,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 66, 139, 202),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
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
                                        fontSize: 24),
                                  ),
                                  Consumer<PerfilProvider>(
                                    builder: (context, perfilProvider, child) {
                                      return FutureBuilder(
                                        future: perfilProvider.getMyContent(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Text(
                                              '${snapshot.data!.get("goalProgress")} ml',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 70, 109),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 32),
                                            );
                                          } else {
                                            return Text(
                                              "...",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Consumer<PerfilProvider>(
                                      builder:
                                          (context, perfilProvider, child) {
                                        return ElevatedButton(
                                          onPressed: () async {
                                            await perfilProvider
                                                .getTodayDrinks();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.replay_outlined),
                                              SizedBox(width: 8),
                                              Text(
                                                'Evaluar progreso',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromRGBO(
                                                171, 198, 253, 1),
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        );
                                      },
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
            ),
          ],
        )
      ],
    );
  }
}
