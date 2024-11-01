import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'add_plant_screen.dart';
import '/widgets/custom_bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> plantData = []; // 식물 데이터 리스트

  // 식물 목록을 새로고침하는 함수
  Future<void> _refreshPlants() async {
    final url = Uri.parse('https://api.rootin.me/v1/plants');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer 11',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          plantData = responseData['data']; // 새로운 식물 데이터를 업데이트
        });
        print("Plants data refreshed successfully.");
      } else {
        print('Failed to load plants data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while refreshing plants data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshPlants(); // 초기 로딩 시 데이터 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/logo_signature_gray.svg', height: 24),
                    Spacer(),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/add_plant.svg'),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPlantScreen()),
                        );

                        if (result == 'newPlantAdded') {
                          await _refreshPlants(); // 새로 등록된 식물이 있으면 새로고침
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final plant = plantData[index];
                  return ListTile(
                    leading: Image.network(plant['imageUrl']),
                    title: Text(plant['plantTypeName']),
                    subtitle: Text('Status: ${plant['status']}'),
                  );
                },
                childCount: plantData.length,
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
