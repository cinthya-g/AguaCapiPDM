import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EstadisticasProvider with ChangeNotifier {
  static final EstadisticasProvider _estadisticasProvider =
      EstadisticasProvider._internal();
  factory EstadisticasProvider() {
    return _estadisticasProvider;
  }

  EstadisticasProvider._internal();

  var selectedDate = TextEditingController();
  var _today = DateFormat('dd-MM-yyyy').format(DateTime.now());

  String noName = "Sin registros";
  String nodrinkPhoto =
      "https://firebasestorage.googleapis.com/v0/b/auth-example-a3044.appspot.com/o/drinks-photos-aguacapi%2Fnodrink.png?alt=media&token=f4d02a80-b4e1-4525-8216-e93e8aae47ec";

  // Cambiar el valor de la fecha seleccionada
  void updateSelectedDate(String newDate) {
    selectedDate.text = newDate;
    notifyListeners();
  }

  // borrar contenido de controller
  void borrarController() {
    selectedDate.clear();
    notifyListeners();
  }

  // Función para obtener el valor del campo createdAt del usuario autenticado
  Future<String> getCreatedAt() async {
    // Obtener documento cuyo nombre es el ID del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("usuarios-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");
    // Query para sacar la data del documento
    var userContent = await userDoc.get();
    final _userContentData = userContent.data()!;
    //print(">> Contenido del usuario: $_userContentData");

    // Obtener el valor del campo createdAt
    String _createdAt = _userContentData["createdAt"];
    //print(">> Fecha de creación: $_createdAt");

    return _createdAt;
  }

// Guardar valores del usuario en la colección estadisticas-aguacapi
  Future<bool> saveGraphValues() async {
    // Ver si el controller tiene algo
    if (selectedDate.text == "") {
      // Si no tiene nada, poner la fecha de hoy
      selectedDate.text = _today;
    }
    // Obtener lista de strings de dias de la semana
    List<String> _week = _obtainWeek();
    // Obtener la lista de cantidades de agua de la semana dependiendo de ls lista anterior
    // y sus nombres
    List<num> _weekWater = await _obtainWeekWater(_week);
    List<String> _sevenDaysDrinks = await _obtainDrinksNames(_week);
    // Obtener la suma de dicha lista
    num _biggestQuantity = obtainBiggestQuantity(_weekWater);
    // Obtener el límite de y
    num _yLimit = _obtainYLimit(_weekWater);
    // Obtener el string que más se repite en _sevenDaysDrinks
    String _mostRepeatedDrink = _obtainMostRepeatedDrink(_sevenDaysDrinks);
    String _drinkPhoto = await _obtainDrinkPhoto(_mostRepeatedDrink);

    // Buscar en la colección estadisticas-aguacapi el documento del usuario autenticado
    var userDoc = await FirebaseFirestore.instance
        .collection("estadisticas-aguacapi")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");
    // Obtenr la data
    var userContent = await userDoc.get();
    // Guardar la lista de semana en "sevenDays"
    await userDoc.update({
      "sevenDays": _week,
      "sevenQuantities": _weekWater,
      "biggestQuantity": _biggestQuantity,
      "sevenDaysDrinks": _sevenDaysDrinks,
      "biggestDrink": _mostRepeatedDrink,
      "drinkPhoto": _drinkPhoto,
      "yLimit": _yLimit,
    });
    return true;
  }

  bool _esBisiesto() {
    int _selectedDateYear = int.parse(selectedDate.text.substring(6, 10));
    bool a = _selectedDateYear % 4 == 0 ? true : false;
    return a;
  }

  List<String> _obtainWeek() {
    // Guardar valores en numero de fecha seleccionada
    int _selectedDateDay = int.parse(selectedDate.text.substring(0, 2));
    int _selectedDateMonth = int.parse(selectedDate.text.substring(3, 5));
    int _selectedDateYear = int.parse(selectedDate.text.substring(6, 10));
    // Fabricador de fechas
    int _day = _selectedDateDay,
        _month = _selectedDateMonth,
        _year = _selectedDateYear;

    // Lista vacía
    List<String> _week = [];
    // Convertir primer valor a string
    String _firstDay = _day.toString().length == 1
        ? "0$_day"
        : _day.toString().length == 2
            ? "$_day"
            : "error";
    String _firstMonth = _month.toString().length == 1
        ? "0$_month"
        : _month.toString().length == 2
            ? "$_month"
            : "error";
    String _firstYear = _year.toString();

    String _firstDate = "$_firstDay-$_firstMonth-$_firstYear";
    // añadir a lista
    _week.add(_firstDate);

    for (int i = 0; i < 6; i++) {
      // Si el año se reinicia
      if (_month == 12 && _day == 31) {
        _year++;
        _day = 1;
        _month = 1;
      }
      // Si es último día de mes de 31 días
      if ((_month == 1 ||
              _month == 3 ||
              _month == 5 ||
              _month == 7 ||
              _month == 8 ||
              _month == 10) &&
          _day == 31) {
        _month++;
        _day = 1;
      }
      // Si es último día de mes con 30 días
      if ((_month == 4 || _month == 6 || _month == 9 || _month == 11) &&
          _day == 30) {
        _month++;
        _day = 1;
      }
      // Si es último día de febrero
      if (!_esBisiesto() && _month == 2 && _day == 28) {
        _month++;
        _day = 1;
      } else if (_esBisiesto() && _month == 2 && _day == 29) {
        _month++;
        _day = 1;
      }
      _day++;
      // Convertir a string el dia, mes y año en formato dd-mm-yyyy
      String _dayString = _day.toString().length == 1
          ? "0$_day"
          : _day.toString().length == 2
              ? "$_day"
              : "error";
      String _monthString = _month.toString().length == 1
          ? "0$_month"
          : _month.toString().length == 2
              ? "$_month"
              : "error";
      String _yearString = _year.toString();

      String _dateString = "$_dayString-$_monthString-$_yearString";

      // Añadir a la lista _week
      _week.add(_dateString);
    }
    // imprimir lista
    print(">> Lista de fechas: $_week");
    return _week;
  }

  Future<List<num>> _obtainWeekWater(List<String> week) async {
    List<num> _weekWater = [];
    num _qty = 0;
    for (int i = 0; i < 7; i++) {
      // Sumar cantidades que coincidan con "date" de bebidas-aguacapi
      print(">> Fecha: ${week[i]}");
      _qty = 0;
      await FirebaseFirestore.instance
          .collection("bebidas-aguacapi")
          .where("idUser",
              isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
          .where("date", isEqualTo: week[i])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _qty += element["quantity"];
        });
      });
      // Añadir a la lista
      _weekWater.add(_qty);
    }
    print(">> Lista de cantidades: $_weekWater");
    return _weekWater;
  }

  Future<List<String>> _obtainDrinksNames(List<String> week) async {
    List<String> _weekDrinks = [];
    String _name;
    for (int i = 0; i < 7; i++) {
      // Sumar cantidades que coincidan con "date" de bebidas-aguacapi
      //print(">> Fecha: ${week[i]}");
      _name = "";
      await FirebaseFirestore.instance
          .collection("bebidas-aguacapi")
          .where("idUser",
              isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
          .where("date", isEqualTo: week[i])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _name = element["name"];
          if (_name != "") {
            _weekDrinks.add(_name);
          }
        });
      });
      // Añadir a la lista

    }
    print(">> Lista de cantidades: $_weekDrinks");
    return _weekDrinks;
  }

  num obtainBiggestQuantity(List<num> weekWater) {
    num _biggestQuantity = 0;
    for (int i = 0; i < 7; i++) {
      _biggestQuantity += weekWater[i];
    }
    return _biggestQuantity;
  }

  // Obtener los 7 valores de cantidades a partir de las fechas
  Future<List<int>> getNumbers() async {
    // Simular una tarea asincrónica que toma tiempo
    await Future.delayed(Duration(seconds: 1));

    // Devolver una lista de números
    return [1, 2, 3, 4, 5];
  }

  String _obtainMostRepeatedDrink(List<String> sevenDaysDrinks) {
    String _mostRepeatedDrink = "";
    int _mostRepeatedDrinkQty = 0;
    int _qty = 0;
    for (int i = 0; i < sevenDaysDrinks.length; i++) {
      _qty = 0;
      for (int j = 0; j < sevenDaysDrinks.length; j++) {
        if (sevenDaysDrinks[i] == sevenDaysDrinks[j]) {
          _qty++;
        }
      }
      if (_qty > _mostRepeatedDrinkQty) {
        _mostRepeatedDrinkQty = _qty;
        _mostRepeatedDrink = sevenDaysDrinks[i];
      }
    }
    return _mostRepeatedDrink;
  }

  // Obtener la foto de la bebida más repetida
  Future<String> _obtainDrinkPhoto(String drinkName) async {
    String _drinkPhoto = "";
    await FirebaseFirestore.instance
        .collection("bebidas-aguacapi")
        .where("idUser", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
        .where("name", isEqualTo: drinkName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _drinkPhoto = element["photo"];
      });
    });
    return _drinkPhoto;
  }

  // Obtener la cantidad más grande de la semana para limitar el eje Y
  num _obtainYLimit(List<num> weekWater) {
    num _yLimit = 0;
    for (int i = 0; i < 7; i++) {
      if (weekWater[i] > _yLimit) {
        _yLimit = weekWater[i];
      }
    }
    return _yLimit;
  }
}
