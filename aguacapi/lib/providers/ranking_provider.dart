import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RankingProvider extends ChangeNotifier {
  static final RankingProvider _rankingProvider = RankingProvider._internal();
  factory RankingProvider() {
    return _rankingProvider;
  }

  RankingProvider._internal();

  final query1 = FirebaseFirestore.instance
      .collection('usuarios-aguacapi')
      .where("rankingPermission", isEqualTo: true)
      .orderBy("goalProgress", descending: true)
      .limit(10)
      .snapshots();
}
