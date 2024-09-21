import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // White background
      ),
      home: HomeScreen(),
    );
  }
}
