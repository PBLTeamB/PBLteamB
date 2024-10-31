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

  void addRoom() async {
    String? newRoom = await showDialog(
      context: context,
      builder: (context) {
        String roomName = "";
        return AlertDialog(
          title: const Text('Add a new room'),
          content: TextField(
            onChanged: (value) {
              roomName = value;
            },
            decoration: const InputDecoration(hintText: 'Enter room name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, roomName);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (newRoom != null && newRoom.isNotEmpty) {
      setState(() {
        rooms.add(newRoom);
        selectedIndex = rooms.length - 1; // 새로 추가된 방을 선택 상태로 설정
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
              itemCount: rooms.length + 1,
              itemBuilder: (context, index) {
                if (index == rooms.length) {
                  return ElevatedButton(
                    onPressed: addRoom,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('+ Add Room'),
                  );
                }

                final room = rooms[index];
                return ElevatedButton(
                  onPressed: () => onSelectRoom(index),
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
                      // 다음 단계로 이동하는 로직을 추가할 수 있습니다.
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
