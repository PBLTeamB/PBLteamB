import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'add_plant_screen.dart';
import '/widgets/custom_bottom_nav_bar.dart';


class FilterButtonWidget extends StatelessWidget {
  final String label;

  FilterButtonWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.02,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(width: 4),
          Transform.rotate(
            angle: -1.5708, // -90 degrees in radians
            child: SvgPicture.asset(
              'assets/icons/arrow.svg',
              height: 12, // Original size (24) * 50%
              width: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(), // iOS 스타일의 스크롤 물리 효과 추가
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 20), // AppBar를 20px 내려오도록 설정
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/logo_signature_gray.svg', height: 24),
                    Spacer(), // 공간을 띄워주기 위한 Spacer 위젯 추가
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/add_plant.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPlantScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 32),
                    // Today's Task Section
                    Text(
                      "Today's Task",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        height: 1.36,
                        letterSpacing: -0.01,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You have 1 plant waiting to be watered',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    height: 1.36,
                                    letterSpacing: -0.01,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Check your task ->',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1.36,
                                    letterSpacing: -0.01,
                                    color: Color(0xff757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Image.asset('assets/images/banner_plant.png', height: 80), // Corrected path from 'assets/icons/banner_plant.svg'
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    // My Plants Section
                    Text(
                      "My plants",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        height: 1.36,
                        letterSpacing: -0.01,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterButtonWidget(label: 'All status'),
                          SizedBox(width: 8.0),
                          FilterButtonWidget(label: 'All locations'),
                          SizedBox(width: 8.0),
                          FilterButtonWidget(label: 'All rooms'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return PlantCard();
                  },
                  childCount: 4,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}


class PlantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    'assets/images/card_plant.svg',
                    color: Color(0xff757575),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: SvgPicture.asset(
                    'assets/icons/status_ideal.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4), // Added 4px space between image and text
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pink Quil',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.36,
                    letterSpacing: -0.02, 
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  'In Livingroom',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.36,
                    letterSpacing: -0.02,
                    color: Color(0xff757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}