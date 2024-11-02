import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'add_plant_detail_screen.dart'; // AddPlantDetailScreen 파일 경로에 맞게 수정

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  List<dynamic> plantList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlantList();
  }

Future<void> fetchPlantList() async {
  var headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer 11',
  };
  var request = http.Request('GET', Uri.parse('https://api.rootin.me/v1/plant-types?skip=0&size=10'));

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print('API Response: $responseBody'); // 전체 API 응답 확인
      final data = json.decode(responseBody);
      setState(() {
        plantList = data['data'].map((plant) {
          print('Plant data: $plant'); // 각 plant의 데이터를 확인
          return {
            'id': plant['id'],
            'name': plant['name'],
            'subname': plant['subname'],
            'imageUrl': plant['imageUrl']
          };
        }).toList();
        isLoading = false;
      });
    } else {
      print('Failed to load plant list: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/icons/close_lg.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Identify your plant',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 22,
                height: 1.36,
                letterSpacing: -0.01,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Search by plant name or use an image to identify.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.36,
                letterSpacing: -0.02,
                color: Color(0xff757575),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffe0e0e0),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Which one to add?',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.36,
                                letterSpacing: -0.02,
                                color: Color(0xff757575),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 0),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/camera.svg'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/identify_plant');
                  },
                ),
              ],
            ),
            const SizedBox(height: 36),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: plantList.length,
                      itemBuilder: (context, index) {
                        final plant = plantList[index];
                        return GestureDetector(
                          onTap: () {
                            print('Navigating to AddPlantDetailScreen with data: $plant'); // plant 전체 데이터 확인
                            print('Plant id: ${plant['id']}'); // 개별적으로 id도 확인
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPlantDetailScreen(
                                  id: plant['id'] ?? 'Plant id',
                                  name: plant['name'] ?? 'Plant name',
                                  subname: plant['subname'] ?? 'Sub plant name',
                                  imageUrl: plant['imageUrl'] ?? 'assets/images/default_plant.png',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    plant['imageUrl'] ?? 'assets/images/default_plant.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant['name'] ?? 'Plant name',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        height: 1.36,
                                        letterSpacing: -0.02,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      plant['subname'] ?? 'Sub plant name',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        height: 1.36,
                                        letterSpacing: -0.02,
                                        color: Color(0xff757575),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}