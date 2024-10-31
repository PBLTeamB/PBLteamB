import 'package:flutter/material.dart';
import '/widgets/connect_sensor_modal.dart';

class ConfirmPlantScreen extends StatelessWidget {
  // 최종 서버 API에서 이미 받아온 데이터
  final String plantName;
  final String roomName;
  final String imageUrl;

  const ConfirmPlantScreen({
    Key? key,
    required this.plantName,
    required this.roomName,
    required this.imageUrl,
  }) : super(key: key);

  // 모달을 띄우는 함수
  void _showConnectSensorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6), // 배경색과 투명도 설정
      builder: (context) => ConnectSensorModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Confirm Plant'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl, // 서버에서 받아온 이미지 URL 사용
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            plantName,
            style: const TextStyle(
              fontFamily: "inter",
              fontSize: 24,
              height: 1.36,
              letterSpacing: -0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'In $roomName',
            style: const TextStyle(
              fontSize: 16,
              height: 1.36,
              letterSpacing: -0.02,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => _showConnectSensorModal(context),
              child: const Text(
                'Continue to add sensor',
                style: TextStyle(
                  fontFamily: "inter",
                  fontSize: 16,
                  letterSpacing: -0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
