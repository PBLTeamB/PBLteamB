import 'package:flutter/material.dart';
import 'room_selection_screen.dart'; // RoomSelectionScreen 파일 import

class SiteSelectionScreen extends StatefulWidget {
  final String name;
  final String subname;
  final String imageUrl;

  const SiteSelectionScreen({
    Key? key,
    required this.name,
    required this.subname,
    required this.imageUrl,
  }) : super(key: key);

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
        selectedIndex = sites.length - 1; // 새로 추가된 사이트를 선택 상태로 설정
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
                        borderRadius: BorderRadius.circular(8), // 테두리 반경 조정
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
