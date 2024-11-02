import 'package:flutter/material.dart';


class IdentifyPlantScreen extends StatelessWidget {
  const IdentifyPlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identify Plant'),
      ),
      body: Center(
        child: Text(
          'This is the Identify Plant Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
