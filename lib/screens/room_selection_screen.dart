import 'package:flutter/material.dart';

class RoomSelectionScreen extends StatefulWidget {
  final String site;

  const RoomSelectionScreen({Key? key, required this.site}) : super(key: key);

  @override
  _RoomSelectionScreenState createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  List<String> rooms = ["Livingroom", "Bedroom", "Kitchen", "Bathroom"]; // 예시 데이터
  int? selectedIndex; // 선택된 아이템의 인덱스를 저장
  bool isContinueEnabled = false;

  void onSelectRoom(int index) {
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
        title: Text('Choose a room in ${widget.site}'),
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
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return ElevatedButton(
                  onPressed: () => onSelectRoom(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(
                      color: selectedIndex == index ? Colors.black : Colors.grey,
                    ),
                  ),
                  child: Text(room),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isContinueEnabled
                  ? () {
                    }
                      // 다음 단계로 이동하는 로직을 추가할 수 있습니다.
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
