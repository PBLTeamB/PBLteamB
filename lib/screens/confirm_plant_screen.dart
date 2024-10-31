import 'package:flutter/material.dart';

class ConfirmPlantScreen extends StatelessWidget {
  final String plantName;
  final String roomName;
  final String imageUrl;

  const ConfirmPlantScreen({
    Key? key,
    required this.plantName,
    required this.roomName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Confirm Plant'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'In $roomName',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // 여기서 센서를 연결하는 로직을 추가할 수 있습니다.
              },
              child: const Text('Continue to Connect Sensor'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToConfirmPlantScreen(BuildContext context, String plantName, String roomName, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfirmPlantScreen(
        plantName: plantName,
        roomName: roomName,
        imageUrl: imageUrl,
      ),
    ),
  );
}
