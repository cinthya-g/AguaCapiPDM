import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:aguacapi/providers/nuevo_consumo_provider.dart';
import 'package:provider/provider.dart';
import 'package:aguacapi/providers/choose_picture_provider.dart';

import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';

class NuevoConsumo extends StatelessWidget {
  const NuevoConsumo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  "Añadir consumo",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "¡Nuevo registro!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.date_range, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("¿Cuándo?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Consumer<NuevoConsumoProvider>(builder: (context, provider, _) {
                return TextField(
                    readOnly: true,
                    controller: provider.dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Selecciona una fecha',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        provider.dateController.text = formattedDate;
                      }
                    });
              }),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.abc, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("¿Qué tomaste?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Consumer<NuevoConsumoProvider>(builder: (context, provider, _) {
                return TextField(
                    controller: provider.nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Té chai',
                    ),
                    onTap: () {});
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.water_drop, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("¿Cómo se ve?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // foto
              Consumer<ChoosePictureProvider>(builder: (context, provider, _) {
                return _selectImage(provider);
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.numbers_rounded, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("¿Cuánto?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Consumer<NuevoConsumoProvider>(builder: (context, provider, _) {
                return TextField(
                    controller: provider.quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Cantidad en mililitros',
                    ),
                    onTap: () {});
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.water_drop, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("O elige una que ya hayas creado:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Consumer<NuevoConsumoProvider>(
                builder: (context, provider, child) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    child: FirestoreListView(
                      query: FirebaseFirestore.instance
                          .collection("bebidas-aguacapi")
                          .where("idUser",
                              isEqualTo:
                                  "${FirebaseAuth.instance.currentUser!.uid}")
                          .where("repeated", isEqualTo: false),
                      itemBuilder: (context, snapshot) {
                        return Container(
                          height: 220,
                          width: 230,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: acBlue100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data()["photo"],
                                  ),
                                  radius: 43,
                                ),
                                Text(
                                  snapshot["name"],
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: acBrown),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot["quantity"].toString() + " ml",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: acBrown),
                                ),
                                SizedBox(height: 5),
                                IconButton(
                                    onPressed: () async {
                                      provider.nameController.text =
                                          snapshot.data()["name"];
                                      provider.quantityController.text =
                                          snapshot
                                              .data()["quantity"]
                                              .toString();
                                      provider.drinkPhotoExists.text =
                                          snapshot.data()["photo"];
                                      provider.dateController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now());

                                      await provider.guardarNuevaBebida(true);
                                      await provider.getTodayDrinks();
                                      provider.borrarControllers();
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar
                                        ..showSnackBar(SnackBar(
                                          content: Text(
                                              "Bebida añadida correctamente"),
                                          backgroundColor: acSuccess,
                                        ));
                                    },
                                    icon: Icon(Icons.add_rounded))
                              ],
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Consumer<NuevoConsumoProvider>(builder: ((context, provider, _) {
                return ElevatedButton(
                    onPressed: () {
                      // Borrar controllers
                      provider.borrarControllers();
                    },
                    child: Text("Reiniciar formulario"),
                    style: ElevatedButton.styleFrom(
                      primary: acOrange,
                      onPrimary: acBackgroundWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ));
              })),
              SizedBox(height: 10),
              Consumer<NuevoConsumoProvider>(
                  builder: ((context, provider, child) {
                return ElevatedButton(
                    onPressed: () async {
                      if (await provider.guardarNuevaBebida(false)) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text('Bebida guardada'),
                              backgroundColor: acSuccess,
                            ),
                          );
                      }
                      ;
                      await provider.getTodayDrinks();
                      provider.borrarControllers();
                    },
                    child: Text("Guardar bebida"),
                    style: ElevatedButton.styleFrom(
                      primary: acBlue50,
                      onPrimary: acBackgroundWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ));
              })),
              SizedBox(height: 20),

              Text(
                "o en su lugar, elimina un consumo anterior:",
                style: TextStyle(
                    color: acBrown, fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 35, color: acOrange50),
                    SizedBox(width: 10),
                    Text("¿Cuál quitamos?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: acBrown)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Consumer<NuevoConsumoProvider>(
                builder: (context, provider, child) {
                  return Container(
                    height: 240,
                    width: double.infinity,
                    child: FirestoreListView(
                      query: FirebaseFirestore.instance
                          .collection("bebidas-aguacapi")
                          .where("idUser",
                              isEqualTo:
                                  "${FirebaseAuth.instance.currentUser!.uid}"),
                      itemBuilder: (context, snapshot) {
                        return Container(
                          height: 240,
                          width: 230,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: acOrange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data()["photo"],
                                  ),
                                  radius: 43,
                                ),
                                Text(
                                  snapshot["name"],
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: acBrown),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  snapshot["quantity"].toString() + " ml",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: acBrown),
                                ),
                                Text(
                                  snapshot["date"],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: acGrey),
                                ),
                                SizedBox(height: 3),
                                IconButton(
                                    onPressed: () async {
                                      await provider.deleteDrink(snapshot.id);
                                      await provider.getTodayDrinks();
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          content: Text(
                                              "Bebida eliminada correctamente"),
                                          backgroundColor: acOrange50,
                                        ));
                                    },
                                    icon: Icon(Icons.delete_rounded))
                              ],
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectImage(ChoosePictureProvider prov) {
    return GestureDetector(
      onTap: () {
        prov.choosePictureFromCamera();
      },
      child: prov.getPicture == null
          ? Container(
              height: 90,
              width: double.infinity,
              color: acOrange100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Añade una foto",
                      style: TextStyle(color: acBrown, fontSize: 20)),
                  SizedBox(width: 15),
                  Icon(Icons.add_a_photo, color: acBrown, size: 30)
                ],
              ))
          : Image.file(prov.getPicture!),
    );
  }
}
