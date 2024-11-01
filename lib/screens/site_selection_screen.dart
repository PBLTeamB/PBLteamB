import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_selection_screen.dart';

class SiteSelectionScreen extends StatefulWidget {
  final int id;
  final String name;
  final String subname;
  final String imageUrl;

  const SiteSelectionScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _SiteSelectionScreenState createState() => _SiteSelectionScreenState();
}

class _SiteSelectionScreenState extends State<SiteSelectionScreen> {
  List<Map<String, dynamic>> sites = []; // API로부터 추출한 데이터
  int? selectedIndex;
  bool isContinueEnabled = false;

  @override
  void initState() {
    super.initState();
    getSites(); // API 호출하여 사이트 목록 가져오기
  }

  Future<void> getSites() async {
    final url = Uri.parse('https://api.rootin.me/v1/categories');
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer 11', // 인증 토큰
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      final uniqueSites = <String, Map<String, dynamic>>{}; // 중복 제거용

      for (var item in data) {
        final name = item['name'];
        if (name.contains('/')) {
          final siteName = name.split('/')[0];
          uniqueSites[siteName] = {
            'categoryId': item['id'],
            'siteName': siteName,
          };
        }
      }

      setState(() {
        sites = uniqueSites.values.toList(); // 중복 제거 후 List로 변환
      });
    } else {
      print('Failed to load sites');
    }
  }

  void onSelectSite(int index) {
    setState(() {
      selectedIndex = index;
      isContinueEnabled = true;
    });
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
      body: Column(
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
                  onPressed: () => onSelectSite(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(
                      color: selectedIndex == index ? Colors.black : Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(site['siteName']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isContinueEnabled
                  ? () {
                      final selectedSite = sites[selectedIndex!];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomSelectionScreen(
                            site: selectedSite['siteName'],
                            id: widget.id,
                            name: widget.name,
                            subname: widget.subname,
                            imageUrl: widget.imageUrl,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
