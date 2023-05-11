import 'package:aguacapi/providers/estadisticas_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:intl/intl.dart';

import 'package:aguacapi/content/mybarchart.dart';
import 'package:provider/provider.dart';

class Estadisticas extends StatelessWidget {
  const Estadisticas({super.key});

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
                  "Estadísticas",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "de hidratación semanal",
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
        Padding(
          padding: const EdgeInsets.only(right: 13.0, left: 13.0),
          child: Consumer<EstadisticasProvider>(
              builder: (context, eProvider, child) {
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                        readOnly: true,
                        controller: eProvider.selectedDate,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Día para iniciar tu semana de estadísticas',
                            suffixIcon: Icon(Icons.calendar_today)),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            eProvider.selectedDate.text = formattedDate;
                          } else {
                            print('Date is not selected');
                          }
                        }),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: acBlue50,
                    fixedSize: const Size(50, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    // Construir gráfica
                    if (await eProvider.saveGraphValues()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gráfica construida'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No se pudo construir la gráfica'),
                        ),
                      );
                    }
                  },
                  child: Icon(Icons.search),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: acOrange50,
                    fixedSize: const Size(50, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    eProvider.borrarController();
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.pie_chart, size: 35, color: acOrange50),
              SizedBox(width: 10),
              Text("Mililitros por día",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: acBrown)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
          child: Container(
            margin: EdgeInsets.all(2),
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: acBlue100),
            // Gráfica de barras
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: MyBarChart(),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.thumb_up, size: 35, color: acOrange50),
              SizedBox(width: 10),
              Text("Bebida más consumida de la semana",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: acBrown)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Consumer<EstadisticasProvider>(builder: ((context, eProvider, child) {
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('estadisticas-aguacapi')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                String _photo = "${snapshot.data!.get("drinkPhoto")}".isEmpty ||
                        "${snapshot.data!.get("drinkPhoto")}" == ""
                    ? eProvider.nodrinkPhoto
                    : "${snapshot.data!.get("drinkPhoto")}";
                String _drinkName =
                    "${snapshot.data!.get("biggestDrink")}".isEmpty ||
                            "${snapshot.data!.get("biggestDrink")}" == ""
                        ? eProvider.noName
                        : "${snapshot.data!.get("biggestDrink")}";
                return Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: acBlue100),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: acOrange, // color del borde
                              width: 6, // ancho del borde
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: Image.network(_photo).image,
                          ),
                        ),
                        Text(_drinkName,
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w500,
                                color: acBlue)),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              });
        })),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.thumb_up, size: 35, color: acOrange50),
              SizedBox(width: 10),
              Text("Mililitros totales de la semana",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: acBrown)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: acBlue100),
            child: Column(
              children: [
                SizedBox(height: 15),
                Consumer<EstadisticasProvider>(
                    builder: ((context, eProvider, child) {
                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('estadisticas-aguacapi')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Text(
                            "${snapshot.data!.get("biggestQuantity")} ml",
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w400,
                                color: acBlue));
                      });
                })),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
