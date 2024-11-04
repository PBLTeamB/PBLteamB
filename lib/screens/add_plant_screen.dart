import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'add_plant_detail_screen.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  List<dynamic> plantList = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

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
    var request = http.Request(
        'GET', Uri.parse('https://api.rootin.me/v1/plant-types?skip=0&size=10'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        setState(() {
          plantList = data['data'].map((plant) {
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
      backgroundColor: const Color(0xffF6F6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Close Button with Circular Background
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE7E7E7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      width: 24,
                      height: 24,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Title and Subtitle
            const Text(
              'Identify your plant',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Search by plant name or use an image to identify.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xff6F6F6F),
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar with Icons
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      color: const Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 20,
                          height: 20,
                          color: const Color(0xff757575),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Which one to add?',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff757575),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                // Optionally, you could implement search logic here to filter the plantList
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Camera Button with Black Background
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(11),
                  child: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // The plant list or loading indicator
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: plantList.length,
                      itemBuilder: (context, index) {
                        final plant = plantList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPlantDetailScreen(
                                  id: plant['id'] ?? 'Plant id',
                                  name: plant['name'] ?? 'Plant name',
                                  subname: plant['subname'] ?? 'Sub plant name',
                                  imageUrl: plant['imageUrl'] ??
                                      'assets/images/default_plant.png',
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
                                    plant['imageUrl'] ??
                                        'assets/images/default_plant.png',
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
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      plant['subname'] ?? 'Sub plant name',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
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
