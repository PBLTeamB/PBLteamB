import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/plant_detail.dart';

class PlantDetailScreen extends StatefulWidget {
  final int plantId;

  const PlantDetailScreen({Key? key, required this.plantId}) : super(key: key);

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late Future<PlantDetail> plantDetailFuture;
  late Future<Map<String, dynamic>> moistureTrendFuture;
  late Future<Map<String, dynamic>> upcomingCareFuture;

  @override
  void initState() {
    super.initState();
    plantDetailFuture = fetchPlantDetail(widget.plantId);
    moistureTrendFuture = fetchMoistureTrend(widget.plantId);
    upcomingCareFuture = fetchUpcomingCare(widget.plantId);
  }

  Future<PlantDetail> fetchPlantDetail(int plantId) async {
    final response = await http.get(Uri.parse('https://api.rootin.me/v1/plants/$plantId'));

    if (response.statusCode == 200) {
      return PlantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load plant details');
    }
  }

  Future<Map<String, dynamic>> fetchMoistureTrend(int plantId) async {
    final response = await http.get(Uri.parse('https://api.rootin.me/v1/plant/$plantId/moisture-trend'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load moisture trend');
    }
  }

  Future<Map<String, dynamic>> fetchUpcomingCare(int plantId) async {
    final response = await http.get(Uri.parse('https://api.rootin.me/v1/plant/$plantId/upcoming'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load upcoming care schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<PlantDetail>(
              future: plantDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No plant details available');
                } else {
                  final plant = snapshot.data!;
                  return Column(
                    children: [
                      Image.network(plant.imageUrl),
                      Text(plant.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Location: ${plant.location}'),
                      Wrap(
                        children: plant.careTips.map((tip) => Chip(label: Text(tip))).toList(),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>>(
              future: moistureTrendFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final trendData = snapshot.data;
                  return Text('Moisture Trend: ${trendData?['trend'] ?? 'N/A'}');
                }
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>>(
              future: upcomingCareFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final upcomingData = snapshot.data;
                  return Text('Upcoming Care: ${upcomingData?['next_event'] ?? 'N/A'}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
