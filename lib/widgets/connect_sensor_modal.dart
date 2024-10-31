import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectSensorModal extends StatelessWidget {
  Future<void> _registerPlant(BuildContext context) async {
    final url = Uri.parse('https://api.rootin.me/v1/plants');
    print("Starting POST request to register plant"); // 디버깅 메시지

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

    print("Response status: ${response.statusCode}"); // 응답 상태 코드 확인
    print("Response body: ${response.body}"); // 응답 본문 확인

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plant registered successfully!')),
      );
      Navigator.pop(context); // 모달 닫기
      Navigator.pushReplacementNamed(context, '/home_screen'); // home_screen으로 이동
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
              await _registerPlant(context); // 비동기 처리 확인
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
