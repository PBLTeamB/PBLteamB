import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectSensorModal extends StatelessWidget {
  final int plantTypeId; // String에서 int로 변경
  final int categoryId;   // String에서 int로 변경
  final String sensorId;
  final String imageUrl;

  ConnectSensorModal({
    required this.plantTypeId,
    required this.categoryId,
    required this.sensorId,
    required this.imageUrl,
  });

  Future<void> _registerPlant(BuildContext context) async {
    final url = Uri.parse('https://api.rootin.me/v1/plants');
    print("Starting POST request to register plant");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: json.encode({
        'plantTypeId': plantTypeId, // int 타입으로 전달
        'categoryId': categoryId,   // int 타입으로 전달
        'sensorId': sensorId,
        'imageUrl': imageUrl,
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plant registered successfully!')),
      );
      Navigator.pop(context, 'newPlantAdded'); // 모달을 닫고 "newPlantAdded" 반환
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register plant. Error: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Text(
            'Detecting Sensor',
            style: TextStyle(
              fontFamily: "inter",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'To enter pairing mode, hold the button at the top of your sensor for about 3-5s.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              await _registerPlant(context);
            },
            child: const Text('Connect'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
