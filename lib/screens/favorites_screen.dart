import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/weather.dart';
import 'package:myapp/services/weather_service.dart';
import 'package:myapp/widgets/weather_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> _favorites = [];
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Method to load favorites from shared preferences
  void _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _favorites = prefs.getStringList('favorites') ?? [];
      });
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // Method to add a favorite city
  void _addFavorite(String city) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _favorites.add(city);
        prefs.setStringList('favorites', _favorites);
      });
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  // Method to remove a favorite city
  void _removeFavorite(String city) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _favorites.remove(city);
        prefs.setStringList('favorites', _favorites);
      });
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  // Method to get weather data for a city
  Future<Weather> _getWeather(String city) async {
    try {
      return await _weatherService.getWeather(city);
    } catch (e) {
      print('Error getting weather data: $e');
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Weather>(
            future: _getWeather(_favorites[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(
                  title: Text('Loading...'),
                );
              } else if (snapshot.hasError) {
                return const ListTile(
                  title: Text('Error loading weather data'),
                );
              } else if (snapshot.hasData) {
                return WeatherCard(
                  weather: snapshot.data!,
                  onDelete: () => _removeFavorite(_favorites[index]),
                );
              } else {
                return const ListTile(
                  title: Text('No data'),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController _controller = TextEditingController();
              return AlertDialog(
                title: const Text('Add Favorite City'),
                content: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'City Name',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _addFavorite(_controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
