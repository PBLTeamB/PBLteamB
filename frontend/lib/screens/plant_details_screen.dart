import 'package:flutter/material.dart';

class PlantDetailsScreen extends StatefulWidget {
  final String plantName;

  const PlantDetailsScreen({required this.plantName});

  @override
  _PlantDetailsScreenState createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  bool _isMoistureExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My plants'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/plant_placeholder.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.plantName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'New plant!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildExpandableTile(
              title: 'Soil Moisture',
              content: _isMoistureExpanded ? _buildMoistureDetails() : null,
              isExpanded: _isMoistureExpanded,
              onExpand: () {
                setState(() {
                  _isMoistureExpanded = !_isMoistureExpanded;
                });
              },
            ),
            _buildExpandableTile(
              title: 'Sunlight',
              content: const Text('Appropriate level'),
              isExpanded: false,
            ),
            _buildExpandableTile(
              title: 'Nutrient',
              content: const Text('Appropriate level'),
              isExpanded: false,
            ),
            _buildExpandableTile(
              title: 'Repotting Period',
              content: const Text('Appropriate level'),
              isExpanded: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile({
    required String title,
    Widget? content,
    required bool isExpanded,
    VoidCallback? onExpand,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: const Text('Appropriate level'),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: onExpand,
        ),
        if (isExpanded && content != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: content,
          ),
      ],
    );
  }

  Widget _buildMoistureDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Overall moisture',
                  style: TextStyle(
                    color: Color(0xFF242323),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '65%',
                  style: TextStyle(
                    color: Color(0xFF242323),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Last watering time',
                  style: TextStyle(
                    color: Color(0xFF242323),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '2 days ago',
                  style: TextStyle(
                    color: Color(0xFF242323),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoistureLevelBox('Getting dry'),
                const SizedBox(height: 10),
                _buildMoistureLevelBox('Moderately humid'),
                const SizedBox(height: 10),
                _buildMoistureLevelBox('Moderately humid', isDarker: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoistureLevelBox(String label, {bool isDarker = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDarker ? const Color(0xFFA0A0A0) : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
