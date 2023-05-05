import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  static final HomePageProvider _homePageProvider =
      HomePageProvider._internal();
  factory HomePageProvider() {
    return _homePageProvider;
  }

  HomePageProvider._internal();
}
