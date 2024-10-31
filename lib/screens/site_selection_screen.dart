import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_selection_screen.dart'; // RoomSelectionScreen 파일 import

class SiteSelectionScreen extends StatefulWidget {
  @override
  _SiteSelectionScreenState createState() => _SiteSelectionScreenState();
}

class _SiteSelectionScreenState extends State<SiteSelectionScreen> {
  List<String> sites = [];
  List<Map<String, String>> siteRoomData = []; // 사이트와 방 정보를 저장하는 리스트
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSiteRoomData();
  }

  Future<void> fetchSiteRoomData() async {
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer 11', // 필요한 경우 인증 토큰 설정
    };
    var response = await http.get(
      Uri.parse('https://api.rootin.me/v1/categories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      Set<String> uniqueSites = {}; // 중복된 사이트를 제거하기 위해 Set 사용
      List<Map<String, String>> tempSiteRoomData = [];

      for (var item in data) {
        String fullName = item['name'];
        List<String> parts = fullName.split('/');

        if (parts.length == 2) {
          String site = parts[0];
          String room = parts[1];

          uniqueSites.add(site); // 사이트를 Set에 추가 (중복 제거)
          tempSiteRoomData.add({'site': site, 'room': room});
        }
      }

      setState(() {
        sites = uniqueSites.toList(); // Set을 리스트로 변환하여 저장
        siteRoomData = tempSiteRoomData;
        isLoading = false;
      });
    } else {
      print('Failed to load site and room data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Choose location of the plant'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: sites.length,
                    itemBuilder: (context, index) {
                      final site = sites[index];
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomSelectionScreen(
                                site: site,
                                rooms: siteRoomData
                                    .where((entry) => entry['site'] == site)
                                    .map((entry) => entry['room']!)
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey),
                        ),
                        child: Text(site),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the next step or perform an action
                    },
                    child: const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
