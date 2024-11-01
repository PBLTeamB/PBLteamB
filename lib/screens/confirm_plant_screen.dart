import 'package:flutter/material.dart';
import '/widgets/connect_sensor_modal.dart';

class ConfirmPlantScreen extends StatelessWidget {
  final String id;
  final String plantName;
  final String roomName;
  final String imageUrl;

  const ConfirmPlantScreen({
    Key? key,
    required this.id,
    required this.plantName,
    required this.roomName,
    required this.imageUrl,
  }) : super(key: key);

  // 모달을 띄우는 함수
  void _showConnectSensorModal(BuildContext context) {
    int? plantTypeId;
    int categoryId = _getCategoryId(roomName); // roomName을 기반으로 categoryId 생성

    // plantTypeId를 정수로 변환하고 실패할 경우 기본값 사용
    try {
      plantTypeId = int.parse(id); // id가 정수가 아닌 경우 예외 발생
    } catch (e) {
      print("Invalid plantTypeId: $id. Using default value 0.");
      plantTypeId = 1; // 기본값으로 설정
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => ConnectSensorModal(
        plantTypeId: plantTypeId!, // 변환된 int 값을 전달
        categoryId: categoryId,    // 변환된 int 값을 전달
        sensorId: '1234',
        imageUrl: imageUrl,
      ),
    );
  }

  // roomName을 categoryId로 변환하는 예시 함수
  int _getCategoryId(String roomName) {
    switch (roomName) {
      case 'Bedroom':
        return 1;
      case 'Livingroom':
        return 2;
      case 'Kitchen':
        return 3;
      case 'Bathroom':
        return 4;
      default:
        print("Unknown roomName: $roomName. Using default categoryId 0.");
        return 0; // 기본값
    }
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
              imageUrl,
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
