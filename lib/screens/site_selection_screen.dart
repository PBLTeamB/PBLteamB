import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_selection_screen.dart'; // RoomSelectionScreen 파일 import

class SiteSelectionScreen extends StatefulWidget {
  final String id;
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
  List<String> sites = [];
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
      final siteNames = <String>{}; // 중복 제거를 위해 Set 사용

      for (var item in data) {
        final name = item['name'];
        if (name.contains('/')) {
          siteNames.add(name.split('/')[0]); // '/' 앞의 값을 추가
        }
      }

      setState(() {
        sites = siteNames.toList(); // Set을 List로 변환하여 업데이트
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

  void addSite() async {
    String? newSite = await showDialog(
      context: context,
      builder: (context) {
        String siteName = "";
        return AlertDialog(
          title: const Text('Add a new site'),
          content: TextField(
            onChanged: (value) {
              siteName = value;
            },
            decoration: const InputDecoration(hintText: 'Enter site name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, siteName);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (newSite != null && newSite.isNotEmpty) {
      setState(() {
        sites.add(newSite);
        selectedIndex = sites.length - 1;
        isContinueEnabled = true;
      });
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
              itemCount: sites.length + 1,
              itemBuilder: (context, index) {
                if (index == sites.length) {
                  return ElevatedButton(
                    onPressed: addSite,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('+ Add Site'),
                  );
                }

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
                  child: Text(site),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isContinueEnabled
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomSelectionScreen(
                            site: sites[selectedIndex!],
                            id: widget.id, // id를 int로 변환
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
