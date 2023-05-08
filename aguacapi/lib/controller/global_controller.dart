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
    try {
      bool isServiceEnabled;
      LocationPermission locationPermission;

      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      //return if services are not enabled
      if (!isServiceEnabled) {
        throw Exception('Location services are not enabled.');
      }
      //status of permission
      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else if (locationPermission == LocationPermission.denied) {
        //Request permission
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }
      //Get current location
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      //update values
      _latitude.value = position.latitude;
      _longitude.value = position.longitude;

      //Calling weatherapi
      final weather = await FetchWeatherAPI()
          .processData(position.latitude, position.longitude);

      weatherData.value = weather;

      _isloading.value = false;
    } catch (e) {
      // handle the exception here

      _latitude.value = 43.479631226511735;
      _longitude.value = -110.76144515626352;
      final weatherE = await FetchWeatherAPI()
          .processData(43.479631226511735, -110.76144515626352);

      weatherData.value = weatherE;

      _isloading.value = false;
      print('Error occurred: $e');
      //show error message to user
    }
  }
}
