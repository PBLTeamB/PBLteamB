import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PlantMonitorApp());
}

class PlantMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Monitor',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(), 
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
