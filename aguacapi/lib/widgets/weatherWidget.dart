import 'package:aguacapi/controller/global_controller.dart';
import 'package:aguacapi/model/weather_data_daily.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors/colors.dart';

class WeatherWidget extends StatefulWidget {
  final WeatherDataDaily weatherDataDaily;
  const WeatherWidget({Key? key, required this.weatherDataDaily})
      : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String city = "";
  String locality = "";
  String date = DateFormat('yMMMMd').format(DateTime.now());
  //#######################################################################
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
//#######################################################################

  @override
  void initState() {
    getCity(globalController.getLatitude(), globalController.getLongitude());
    super.initState();
  }

  getCity(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    print(place);
    setState(() {
      locality = place.locality!;
      city = place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: acBlue100, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
                "assets/images/${widget.weatherDataDaily.daily[0].weather![0].icon}.png"),
          ),
          title: Text('$locality, $city',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400, color: acBrown)),
          subtitle: Text(date),
          trailing: Text(
            '${widget.weatherDataDaily.daily[0].temp!.max}°C',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w400, color: acBrown),
          ),
        ),
      ),
    );
  }
}
