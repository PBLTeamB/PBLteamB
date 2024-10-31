import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rootin_app/themes/app_theme.dart';

class PlantCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String statusIcon;

  const PlantCard({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: SvgPicture.asset(
                  statusIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTheme.heading3,
          ),
          Text(
            'In $location',
            style: AppTheme.caption,
          ),
        ],
      ),
    );
  }
}