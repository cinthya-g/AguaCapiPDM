import 'package:aguacapi/model/weather_data.dart';
import 'package:aguacapi/model/weather_data_current.dart';
import 'package:flutter/material.dart';
import 'package:aguacapi/controller/global_controller.dart';
import 'package:aguacapi/model/weather_data_current.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../colors/colors.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final WeatherDataCurrent currentWeather;
  const CurrentWeatherWidget({Key? key, required this.currentWeather})
      : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  String city = "";
  String locality = "";
  String date = DateFormat('yMMMMd').format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    getCity(globalController.getLatitude(), globalController.getLongitude());
  }

  getCity(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      locality = place.locality!;
      city = place.country!;
    });
  }

  String getMessage(double? temp) {
    if (temp! < -10) {
      return "Aguas! Hace un friazo!!!";
    } else if (temp >= -10 && temp < 0) {
      return "Ta fresco mijo! Abrigese machin!";
    } else if (temp >= 0 && temp < 10) {
      return "Hace frillito. Ponte chamarra!";
    } else if (temp >= 10 && temp < 20) {
      return "Hace fresco. Ponte algo comodo.";
    } else if (temp >= 20 && temp < 30) {
      return "Los calores se ponen duros. A tomar chingos de agua!";
    } else if (temp >= 30 && temp < 40) {
      return "Hidratese morro , la calor esta recia!";
    } else {
      return "Afuera es el infierno, tomar agua no te salvara!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: acBlue100, borderRadius: BorderRadius.circular(10)),
        child: locality == 'Jackson'
            ? ListTile(
                title: Text(
                  'Para que este widget funciona, abilita los permisos dentro de la configuracion',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: acBrown),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: openAppSettings,
                  color: acBrown,
                ),
              )
            : ListTile(
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                      "assets/images/${widget.currentWeather.current!.weather![0].icon}.png"),
                ),
                title: Text(getMessage(widget.currentWeather.current!.temp),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: acBrown)),
                subtitle: Text('$locality, $city'),
                trailing: Text(
                  '${widget.currentWeather.current!.temp}°C',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: acBrown),
                ),
              ),
      ),
    );
  }
}
