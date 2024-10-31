import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_bottom_nav_bar.dart';

class CareScreen extends StatefulWidget {
  @override
  _CareScreenState createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  bool isTodayTabSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Care',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    height: 1.36,
                    letterSpacing: -0.01,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/care_history.svg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/setting.svg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      padding: const EdgeInsets.only(right: 2),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE0E0E0),
              ),
              child: Row(
                children: [
                  _buildTabButton('Today', isTodayTabSelected, () {
                    setState(() {
                      isTodayTabSelected = true;
                    });
                  }),
                  _buildTabButton('Upcoming', !isTodayTabSelected, () {
                    setState(() {
                      isTodayTabSelected = false;
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: isTodayTabSelected ? todayPlants.length : upcomingPlants.length,
                itemBuilder: (context, index) {
                  final plant = isTodayTabSelected ? todayPlants[index] : upcomingPlants[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _buildPlantCard(plant),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildTabButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.white : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantCard(Map<String, dynamic> plant) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: plant['image'].toString().endsWith('.svg')
                ? SvgPicture.asset(
                    plant['image'] as String,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    plant['image'] as String,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 60, color: Colors.grey);
                    },
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                plant['name'] as String,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.36,
                  letterSpacing: -0.02,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                plant['location'] as String,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  height: 1.36,
                  letterSpacing: -0.02,
                  color: Color(0xFF757575),
                ),
              ),
              if (isTodayTabSelected && plant['status'] != null) ...[
                const SizedBox(height: 4),
                Text(
                  plant['status']!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.36,
                    letterSpacing: -0.02,
                    color: Color(0xFFFF004F),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (isTodayTabSelected) ...[
          _buildCareStatus(plant),
        ],
      ],
    );
  }

  Widget _buildCareStatus(Map<String, dynamic> plant) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: plant['care'] == 'underwater' ? const Color(0xFFFF004F) : const Color(0xFF06C1C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            plant['care'] == 'underwater'
                ? 'assets/icons/care_underwater.svg'
                : 'assets/icons/care_watered.svg',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 4),
          Text(
            plant['care'] == 'underwater' ? 'Underwater' : 'Watered',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

final todayPlants = [
  {
    'image': 'assets/images/card_plan.svg',
    'name': 'Monstera',
    'location': 'In Balcony',
    'care': 'watered',
  },
  {
    'image': 'assets/images/card_plant.svg',
    'name': 'Variegated Rubber',
    'location': 'In Balcony',
    'status': '2 days ago',
    'care': 'underwater',
  },
  // Add more plant items here
];

final upcomingPlants = [
  {
    'image': 'assets/images/card_plant.svg',
    'name': 'Apple Mint',
    'location': 'In Balcony',
  },
  // Add more plant items here
];
