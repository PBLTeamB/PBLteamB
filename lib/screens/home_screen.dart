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
      'Authorization': 'Bearer 11',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final plants = responseData['data'] ?? [];
        return plants;
      } else {
        print('Failed to load plants data: ${response.statusCode}');
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

  Future<void> deletePlant(String plantId) async {
  final url = Uri.parse('https://api.rootin.me/v1/plants/$plantId'); // Updated endpoint
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer 11', // Replace with a valid token
  };

  try {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) { // Updated status code check
      print('Plant deleted successfully');
      await _refreshPlants(); // Refresh the list after deletion
    } else {
      print('Failed to delete plant: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error occurred while deleting plant: $e');
  }
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
                  final plantId = plant['id']?.toString();
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        if (plantId != null) {
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Plant'),
                              content: const Text('Are you sure you want to delete this plant?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await deletePlant(plantId);
                          }
                        }
                      },
                    ),
                    onTap: () {
                      if (plantTypeId != null) {
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
