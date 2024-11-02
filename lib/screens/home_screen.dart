import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rootin_app/screens/add_plant_screen.dart';
import 'package:rootin_app/screens/plant_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> plantData = [];

  Future<List<dynamic>> fetchPlants() async {
    final url = Uri.parse('https://api.rootin.me/v1/plants');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer 11', // Replace with a valid token
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final plants = responseData['data'] ?? [];

        for (var plant in plants) {
          print('Plant data: $plant');
        }

        return plants;
      } else {
        print('Failed to load plants data: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching plants data: $e');
      return [];
    }
  }

  Future<void> _refreshPlants() async {
    final plants = await fetchPlants();
    setState(() {
      plantData = plants;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _refreshPlants,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddPlantScreen()),
                        );

                        if (result == 'newPlantAdded') {
                          await _refreshPlants();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final plant = plantData[index];
                  final plantTypeId = plant['plantTypeId']?.toString();

                  return ListTile(
                    leading: plant['imageUrl'] != null
                        ? Image.network(
                            plant['imageUrl'],
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          )
                        : const Icon(Icons.image),
                    title: Text(plant['plantTypeName'] ?? 'Unnamed Plant'),
                    subtitle: Text('Status: ${plant['status'] ?? 'Unknown'}'),
                    onTap: () {
                      if (plantTypeId != null) {
                        print('Navigating with plantTypeId: $plantTypeId');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailScreen(
                              plantTypeId: plantTypeId,
                            ),
                          ),
                        );
                      } else {
                        print('Error: plantTypeId is missing for plant at index $index');
                      }
                    },
                  );
                },
                childCount: plantData.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
