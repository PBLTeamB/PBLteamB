// lib/widgets/custom_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/home_screen.dart';
import '/screens/care_screen.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavBar({
    required this.currentIndex,
  });

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeScreen(), // Replace with the corresponding screen
            transitionDuration: Duration(milliseconds: 200), // Removes animation
            reverseTransitionDuration: Duration(milliseconds: 200),
          ),
         );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => CareScreen(), // Replace with the corresponding screen
            transitionDuration: Duration(milliseconds: 200), // Removes animation
            reverseTransitionDuration: Duration(milliseconds: 200),
          ),
         );
        break;  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        onTap: (index) => _navigate(context, index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: currentIndex == 0
                ? SvgPicture.asset('assets/icons/nav_home_active.svg')
                : SvgPicture.asset('assets/icons/nav_home_default.svg'),
            label: 'My Plant',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 1
                ? SvgPicture.asset('assets/icons/nav_care_active.svg')
                : SvgPicture.asset('assets/icons/nav_care_default.svg'),
            label: 'Care',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 2
                ? SvgPicture.asset('assets/icons/nav_community_active.svg')
                : SvgPicture.asset('assets/icons/nav_community_default.svg'),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 3
                ? SvgPicture.asset('assets/icons/nav_profile_active.svg')
                : SvgPicture.asset('assets/icons/nav_profile_default.svg'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
