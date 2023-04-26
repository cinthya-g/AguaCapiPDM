import 'package:aguacapi/api/fetch_weather.dart';
import 'package:aguacapi/model/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //Variables
  final RxBool _isloading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  //Instance for variables
  RxBool checkloading() => _isloading;
  RxDouble get getLatitude => _latitude;
  RxDouble get getLongitude => _longitude;

  final weatherData = WeatherData().obs;

  getData() => weatherData.value;

  @override
  void onInit() {
    if (_isloading.isTrue) {
      getlocation();
    }
    super.onInit();
  }

  getlocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return if services are not enabled
    if (!isServiceEnabled) {
      return Future.error('Location services are not enabled.');
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    } else if (locationPermission == LocationPermission.denied) {
      //Request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    //Get current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update values
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      //Calling weatherapi
      return FetchWeatherAPI().processData(value.latitude, value.longitude);
    }).then((value) {
      weatherData.value = value;
      _isloading.value = false;
    });
  }
}
