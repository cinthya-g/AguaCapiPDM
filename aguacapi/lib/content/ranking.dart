import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/providers/ranking_provider.dart';
import 'package:aguacapi/colors/colors.dart';
import 'package:provider/provider.dart';

class Ranking extends StatelessWidget {
  Ranking({super.key});

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
                  "Ranking de usuarios",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Top hidratación de hoy",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        Consumer<RankingProvider>(builder: (context, rankingProvider, child) {
          return StreamBuilder<QuerySnapshot>(
              stream: rankingProvider.query1,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 12.0, left: 12.0, bottom: 4, top: 4),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: ListTile(
                            tileColor: index == 0
                                ? acGreen
                                : index == 1
                                    ? acGreen50
                                    : index == 2
                                        ? acGreen100
                                        : acGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: acBlue50, // color del borde
                                  width: 2, // ancho del borde
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(
                                    data['profilePhoto'],
                                    scale: 1.0),
                              ),
                            ),
                            title: Text(data['username'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 22)),
                            subtitle: Text(
                                "Consumo: ${data['goalProgress'].toString()} ml",
                                style: TextStyle(fontSize: 18)),
                            trailing: Text("${index + 1}°",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26)),
                          ),
                        ),
                      );
                    });
              });
        }),
      ],
    );
  }
}
