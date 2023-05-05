import 'dart:convert';

import 'package:aguacapi/api/api_key.dart';
import 'package:aguacapi/model/weather_data.dart';
import 'package:aguacapi/model/weather_data_current.dart';
import 'package:aguacapi/model/weather_data_daily.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing data from response -> to json

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString));
    //weatherData = WeatherData(WeatherDataDaily.fromJson(jsonString));
    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutly,hourly";
  return url;
}
