import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:intl/intl.dart';

import 'package:aguacapi/content/mybarchart.dart';

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
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: TextField(
                      readOnly: true,
                      controller: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Selecciona una fecha',
                          suffixIcon: Icon(Icons.calendar_today)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          var formattedDateProvider = formattedDate;
                          print(formattedDate);
                          initialDate:
                          formattedDate;
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
                  backgroundColor: acOrange50,
                  fixedSize: const Size(130, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {},
                child: Text("FILTRAR"),
              ),
            ],
          ),
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
              Text("Bebida más consumida",
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
                Image.asset('assets/images/default.png',
                    height: 220, width: 220, fit: BoxFit.fitHeight),
                Text("Agua embotellada",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: acBlue)),
                Text("Total: 1500 ml",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: acBlue)),
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
