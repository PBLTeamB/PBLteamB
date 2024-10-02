import 'package:flutter/material.dart';
import 'connect_sensor_screen.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  String? selectedPlant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Plant',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who Are We Caring For Today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            _buildCategory('Succulents', 'Plants adapted to arid environments'),
            SizedBox(height: 12),
            _buildPlantGrid([
              'Aloe Vera',
              'Echeveria',
              'Jade Plant',
              'Zebra Plant',
              'Sedum'
            ]),
            SizedBox(height: 24),
            _buildCategory('Foliage', 'Plants grown for their leaves'),
            SizedBox(height: 12),
            _buildPlantGrid(['Monstera', 'Sansevieria', 'Pothos']),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: selectedPlant != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConnectSensorScreen()),
                        );
                      }
                    : null,
                child: Text('Next',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPlant != null
                      ? Colors.green
                      : Colors.grey[300],
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantGrid(List<String> plants) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        String plant = plants[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPlant = plant;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  selectedPlant == plant ? Colors.green[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color:
                    selectedPlant == plant ? Colors.green : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                plant,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategory(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
