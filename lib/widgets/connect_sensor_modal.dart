import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectSensorModal extends StatelessWidget {
  // 서버에서 받은 데이터를 이용하여 POST 요청을 보내기
  Future<void> _registerPlant(BuildContext context) async {
    final url = Uri.parse('https://api.rootin.me/v1/plants');

    // POST 요청을 보내기 위해 서버에서 받아온 값을 body로 전달
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: json.encode({
        'plantTypeId': 1,   // 예시 값
        'categoryId': 2,    // 예시 값
        'sensorId': 1234,   // 예시 값
        'imageUrl': 'https://example.com/image.png', // 예시 값
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context); // 모달 닫기
      Navigator.pushReplacementNamed(context, '/home_screen'); // home_screen으로 이동
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register plant. Please try again.')),
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
            onPressed: () => _registerPlant(context),
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
