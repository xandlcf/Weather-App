import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/weather.dart';
import 'package:myapp/utils/api_keys.dart';

class WeatherService {
  final String apiKey = ApiKeys.openWeatherMapApiKey;

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
