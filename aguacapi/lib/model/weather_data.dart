import 'package:aguacapi/model/weather_data_daily.dart';

class WeatherData {
  final WeatherDataDaily? daily;

  WeatherData([this.daily]);
  WeatherDataDaily getDailyWeather() => daily!;
}
