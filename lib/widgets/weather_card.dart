import 'package:flutter/material.dart';
import 'package:myapp/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback? onDelete;

  WeatherCard({required this.weather, this.onDelete});

  // Method to get background color based on weather description
  Color getBackgroundColor(String description) {
    if (description.contains('cloud')) {
      return Colors.grey[300]!; // Light grey for cloudy
    } else if (description.contains('clear')) {
      return Colors.orange[200]!; // Light orange for clear
    } else {
      return Colors.blue[200]!; // Light blue for neutral
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: getBackgroundColor(weather.description.toLowerCase()),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    weather.cityName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Temperature: ${weather.temperature}°C',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Description: ${weather.description}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              Positioned(
                top: 8.0,
                right: 8.0,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
