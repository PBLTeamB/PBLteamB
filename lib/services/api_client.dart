import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = "https://api.rootin.me";

class ApiClient {
  ApiClient();

  final String _authToken = 'Bearer 11'; // Replace with actual token

  Map<String, String> get _headers => {
    'accept': 'application/json',
    'Authorization': _authToken,
  };

  Future<Map<String, dynamic>> _getRequest(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  Future<bool> _deleteRequest(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.delete(url, headers: _headers);

    if (response.statusCode == 200) {
      print('Resource deleted successfully');
      return true;
    } else {
      print('Failed to delete resource. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  Future<Map<String, dynamic>> getPlantTypeInfo(String plantTypeId) async {
    return await _getRequest('/v1/plant-types?plant_id=$plantTypeId');
  }

  Future<void> healthCheck() async {
    await _getRequest('/v1/health-check');
    print("Server is up");
  }

  Future<Map<String, dynamic>> getPlantInfo(String plantId) async {
    return await _getRequest('/v1/plants/$plantId');
  }

  Future<Map<String, dynamic>> getSoilMoisture(String plantId) async {
    return await _getRequest('/v1/plant/$plantId/moisture-trend');
  }

  Future<Map<String, dynamic>> getUpcomingWatering(String plantId) async {
    return await _getRequest('/v1/plant/$plantId/upcoming');
  }

  // Updated deletePlant method to return a boolean indicating success
  Future<bool> deletePlant(String plantId) async {
    return await _deleteRequest('/v1/plants/$plantId');
  }
}
