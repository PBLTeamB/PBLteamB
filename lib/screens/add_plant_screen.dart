import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPlantScreen extends StatelessWidget {
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/icons/close_lg.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Identify your plant',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 22,
                height: 1.36,
                letterSpacing: -0.01,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Search by plant name or use an image to identify.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.36,
                letterSpacing: -0.02,
                color: Color(0xff757575),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffe0e0e0),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Which one to add?',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.36,
                                letterSpacing: -0.02,
                                color: Color(0xff757575),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 0),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/camera.svg'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/identify_plant');
                  },
                ),
              ],
            ),
            const SizedBox(height: 36),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with dynamic plant card count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SvgPicture.asset(
                            'assets/images/card_plant.svg',
                            color: Color(0xff757575),
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Plant name',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.36,
                                letterSpacing: -0.02,
                                color: Color(0xff000000),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sub plant name',
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
