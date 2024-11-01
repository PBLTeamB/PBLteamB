import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'confirm_plant_screen.dart';

class RoomSelectionScreen extends StatefulWidget {
  final String site;
  final String id;
  final String name;
  final String subname;
  final String imageUrl;

  const RoomSelectionScreen({
    Key? key,
    required this.site,
    required this.id,
    required this.name,
    required this.subname,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _RoomSelectionScreenState createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  List<String> rooms = [];
  int? selectedIndex;
  bool isContinueEnabled = false;

  @override
  void initState() {
    super.initState();
    getRooms(); // API 호출하여 방 목록 가져오기
  }

  Future<void> getRooms() async {
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
      final roomNames = <String>{};

      for (var item in data) {
        final name = item['name'];
        // 선택된 site와 '/' 앞의 값이 일치하는 경우 '/' 뒤의 값을 가져오기
        if (name.startsWith(widget.site + '/')) {
          roomNames.add(name.split('/')[1]); // '/' 뒤의 값을 추가
        }
      }

      setState(() {
        rooms = roomNames.toList(); // Set을 List로 변환하여 업데이트
      });
    } else {
      print('Failed to load rooms');
    }
  }

  void onSelectRoom(int index) {
    setState(() {
      selectedIndex = index;
      isContinueEnabled = true;
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
        selectedIndex = rooms.length - 1;
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
              onPressed: isContinueEnabled && selectedIndex != null && selectedIndex! < rooms.length
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmPlantScreen(
                            id: widget.id, // id를 int로 변환
                            plantName: widget.name,
                            roomName: rooms[selectedIndex!], // selectedIndex 유효성 검사 추가
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
