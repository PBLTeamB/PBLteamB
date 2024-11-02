import 'package:flutter/material.dart';
import 'site_selection_screen.dart'; // SiteSelectionScreen 파일 import

class AddPlantDetailScreen extends StatelessWidget {
  final int id;
  final String name;
  final String subname;
  final String imageUrl;

  const AddPlantDetailScreen({
    super.key,
    required this.id,
    required this.name,
    required this.subname,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    print('Current id in AddPlantDetailScreen: $id'); // id 확인
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(), // 상단 여백
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 24,
                    height: 1.36,
                    letterSpacing: -0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subname,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.36,
                    letterSpacing: -0.02,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(), // 하단 여백
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 48),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Navigating to SiteSelectionScreen with id: $id'); // id 확인
                    // SiteSelectionScreen으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SiteSelectionScreen(
                          id: id, // id를 int로 변환
                          name: name,
                          subname: subname,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ready to add plant',
                    style: TextStyle(
                      fontFamily: "inter",
                      fontSize: 16,
                      letterSpacing: -0.02,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // AddPlantScreen으로 돌아가기
                  },
                  child: const Text(
                    'Search again',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
