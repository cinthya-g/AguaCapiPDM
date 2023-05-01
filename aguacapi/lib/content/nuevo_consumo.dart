import 'package:flutter/material.dart';
import 'package:aguacapi/colors/colors.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:aguacapi/providers/nuevo_consumo_provider.dart';
import 'package:provider/provider.dart';

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
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        provider.dateController.text = formattedDate;
                      } else {
                        print('Date is not selected');
                      }
                    });
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.water_drop_rounded, size: 35, color: acOrange50),
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
              Container(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Crear nueva bebida"),
                        style: TextButton.styleFrom(
                          primary: acBrown,
                          backgroundColor: acOrange100,
                          onSurface: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
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
              TextField(
                  controller: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Cantidad en ml',
                  ),
                  onTap: () async {}),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    // TODO: Guardar el consumo
                  },
                  child: Text("Guardar bebida"),
                  style: ElevatedButton.styleFrom(
                    primary: acBlue50,
                    onPrimary: acBackgroundWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  )),
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
              Container(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Bebida existente"),
                        style: TextButton.styleFrom(
                          primary: acBrown,
                          backgroundColor: acOrange100,
                          onSurface: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
