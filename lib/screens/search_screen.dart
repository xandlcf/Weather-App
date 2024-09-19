import 'package:flutter/material.dart';
import 'package:myapp/services/weather_service.dart';
import 'package:myapp/models/weather.dart';
import 'package:myapp/widgets/weather_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;

  void _searchWeather() async {
    try {
      final weather = await _weatherService.getWeather(_controller.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        _weather = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'City Name',
              ),
            ),
            ElevatedButton(
              onPressed: _searchWeather,
              child: Text('Search'),
            ),
            if (_weather != null)
              WeatherCard(weather: _weather!),
            if (_weather == null && _controller.text.isNotEmpty)
              Text('No weather data found for the city.'),
          ],
        ),
      ),
    );
  }
}
