import 'package:flutter/material.dart';

class AddPlantDetailScreen extends StatelessWidget {
  final String name;
  final String subname;
  final String imageUrl;

  const AddPlantDetailScreen({
    Key? key,
    required this.name,
    required this.subname,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subname,
              style: const TextStyle(
                fontSize: 16,
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add plant logic can go here
              },
              child: Text('Add Plant'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // primary를 backgroundColor로 변경
                textStyle: const TextStyle(fontSize: 16),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Search again logic can go here
              },
              child: Text(
                'Search again',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
