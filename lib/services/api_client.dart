// lib/services/api_client.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = "https://api.rootin.me";

class ApiClient {
  ApiClient();

  Future<Map<String, dynamic>> getPlantTypeInfo(String plantTypeId) async {
    final url = Uri.parse('$baseUrl/v1/plant-types?plant_id=$plantTypeId');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer 11', // Replace with actual token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to load plant type information. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load plant type information');
    }
  }

  // Health check
  Future<void> healthCheck() async {
    final url = Uri.parse('$baseUrl/v1/health-check');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Server is up: ${response.body}");
    } else {
      throw Exception('Failed to load health check');
    }
  }

  // Get plant information
  Future<Map<String, dynamic>> getPlantInfo(String plantId) async {
    final url = Uri.parse('$baseUrl/v1/plants/$plantId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load plant information');
    }
  }

  // Get real-time soil moisture data
  Future<Map<String, dynamic>> getSoilMoisture(String plantId) async {
    final url = Uri.parse('$baseUrl/v1/plant/$plantId/moisture-trend');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load soil moisture data');
    }
  }

  // Get upcoming watering schedule
  Future<Map<String, dynamic>> getUpcomingWatering(String plantId) async {
    final url = Uri.parse('$baseUrl/v1/plant/$plantId/upcoming');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load upcoming watering schedule');
    }
  }
}
