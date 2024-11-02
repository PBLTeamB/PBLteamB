class PlantDetail {
  final int id;
  final String name;
  final String location;
  final String imageUrl;
  final List<String> careTips;

  PlantDetail({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.careTips,
  });

  factory PlantDetail.fromJson(Map<String, dynamic> json) {
    return PlantDetail(
      id: json['id'] != null && json['id'] is int ? json['id'] : 0,  // Default ID if null or not int
      name: json['name'] ?? 'Unknown Plant',
      location: json['location'] ?? 'Unknown Location',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150', // Default image
      careTips: _parseCareTips(json['care_tips']), // Parse care tips safely
    );
  }

  // Helper method to parse care tips, ensuring only strings in the list
  static List<String> _parseCareTips(dynamic careTips) {
    if (careTips is List) {
      return careTips.whereType<String>().toList();
    } else {
      return []; // Return empty list if careTips is not a list or is null
    }
  }
}
