import 'package:flutter/material.dart';
import 'confirmation_screen.dart';

class ConnectSensorScreen extends StatefulWidget {
  @override
  _ConnectSensorScreenState createState() => _ConnectSensorScreenState();
}

class _ConnectSensorScreenState extends State<ConnectSensorScreen> {
  bool isConnecting = false;
  bool isConnected = false;

  void _startConnecting() {
    setState(() {
      isConnecting = true;
    });
    // Simulate sensor connection process
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isConnected = true;
        isConnecting = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Connect Sensor',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              "Please connect the sensor",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Stop Guessing and Save Your Plant",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7B917B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            Stack(
              alignment: Alignment.center,
              children: [
                // Circle for icon placement
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9),
                  ),
                ),
                if (isConnecting)
                  CircularProgressIndicator(
                    color: Colors.purple,
                    strokeWidth: 6,
                  )
                else if (isConnected)
                  // Display "Done!" without the rectangle box
                  Text(
                    "Done!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  Icon(
                    Icons.sensor_door,
                    size: 60,
                    color: Colors.grey,
                  ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: isConnecting || isConnected ? null : _startConnecting,
              child: Text(
                isConnecting ? "Connecting..." : "Connect now",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold), // Bold text
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isConnecting ? Colors.grey : Color(0xFF549154),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                foregroundColor: Colors.white, // Make the text color white
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Skip sensor connection logic
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Later',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Bold text
                      color: Color(0xFF549154),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF549154),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: isConnected
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmationScreen()),
                );
              },
              child: Icon(Icons.arrow_forward),
              backgroundColor: Color(0xFF549154),
            )
          : null,
    );
  }
}
