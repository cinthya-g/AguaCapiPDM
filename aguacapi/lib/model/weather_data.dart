import 'package:aguacapi/model/weather_data_current.dart';
import 'package:aguacapi/model/weather_data_daily.dart';

class WeatherData {
  //final WeatherDataDaily? daily;
  final WeatherDataCurrent? current;
  WeatherData([this.current]);
  //WeatherData([this.daily, this.current]);
  //WeatherDataDaily getDailyWeather() => daily!;
  WeatherDataCurrent getCurrentWeather() => current!;
}
