import 'package:flutter/material.dart';
import 'room_selection_screen.dart'; // RoomSelectionScreen 파일 import

class SiteSelectionScreen extends StatefulWidget {
  @override
  _SiteSelectionScreenState createState() => _SiteSelectionScreenState();
}

class _SiteSelectionScreenState extends State<SiteSelectionScreen> {
  List<String> sites = ["Home", "Workplace", "Outdoor"]; // 예시 데이터
  int? selectedIndex; // 선택된 아이템의 인덱스를 저장
  bool isContinueEnabled = false;

  void onSelectSite(int index) {
    setState(() {
      selectedIndex = index;
      isContinueEnabled = true; // 선택 시 Continue 버튼 활성화
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
                          builder: (context) => RoomSelectionScreen(site: sites[selectedIndex!]),
                        ),
                      );
                    }
                  : null, // 선택되지 않으면 비활성화
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
