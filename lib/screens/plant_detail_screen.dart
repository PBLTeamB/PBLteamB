// lib/screens/plant_detail_screen.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/api_client.dart';

class PlantDetailScreen extends StatefulWidget {
  final String plantTypeId;

  PlantDetailScreen({required this.plantTypeId});

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late Future<Map<String, dynamic>> _plantTypeInfo;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    _plantTypeInfo = _apiClient.getPlantTypeInfo(widget.plantTypeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Type Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _plantTypeInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final dataList = snapshot.data?['data'] as List<dynamic> ?? [];

            final plantTypeData = dataList.firstWhere(
              (element) => element['id'].toString() == widget.plantTypeId,
              orElse: () => null,
            );

            if (plantTypeData == null) {
              return Center(child: Text('No matching plant type information found.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantTypeData['name'] ?? 'No Name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Subname: ${plantTypeData['subname'] ?? 'No Subname'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  if (plantTypeData['imageUrl'] != null)
                    Image.network(plantTypeData['imageUrl']),
                  SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
