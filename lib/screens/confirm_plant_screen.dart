import 'package:flutter/material.dart';
import '/widgets/connect_sensor_modal.dart';

class ConfirmPlantScreen extends StatelessWidget {
  final int id;
  final String plantName;
  final String roomName;
  final int categoryId; // categoryId를 직접 전달받음
  final String imageUrl;

  const ConfirmPlantScreen({
    Key? key,
    required this.id,
    required this.plantName,
    required this.roomName,
    required this.categoryId, // 전달된 categoryId 사용
    required this.imageUrl,
  }) : super(key: key);

  void _showConnectSensorModal(BuildContext context) {
    final plantTypeId = id; // id 값을 plantTypeId로 사용

    print('PlantTypeId in ConfirmPlantScreen: $plantTypeId'); // 확인용 출력
    print('CategoryId in ConfirmPlantScreen: $categoryId'); // 확인용 출력

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => ConnectSensorModal(
        plantTypeId: plantTypeId,
        categoryId: categoryId, // 직접 전달된 categoryId 사용
        sensorId: 1234, // 예시 sensorId
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Current id in ConfirmPlantScreen: $id'); // id 확인
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
