import 'package:flutter/material.dart';
import 'plant_details_screen.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildTopSection(context),
            const SizedBox(height: 24),
            _buildToggleButtons(context),
            const SizedBox(height: 24),
            _buildNotificationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.eco, color: Colors.green),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Irvine, CA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '74°F ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '(60°F ~ 77°F)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'My plants',
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFF549154),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Notifications(1)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationList() {
    return Expanded(
      child: ListView(
        children: [
          Text(
            'To-Do(1)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildNotificationCard(
            leadingIcon: Icons.local_florist,
            title: 'Check out your new plant',
            subtitle: 'Last water time: 8 days ago\nSoil Moisture: 65%',
            onTap: () {},
          ),
          SizedBox(height: 24),
          Text(
            'Done',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildNotificationCard(
            leadingIcon: Icons.water_drop,
            title: 'Water your Aloe Vera!',
            subtitle: 'Last water time: 8 days ago\nSoil Moisture: 32%',
            trailingIcon: Icons.check_circle,
            trailingIconColor: Colors.black,
            onTap: () {},
          ),
          SizedBox(height: 12),
          _buildNotificationCard(
            leadingIcon: Icons.water_drop,
            title: 'Water your Aloe Vera!',
            subtitle: 'Last water time: 8 days ago\nSoil Moisture: 32%',
            trailingIcon: Icons.check_circle,
            trailingIconColor: Colors.black,
            onTap: () {},
          ),
          SizedBox(height: 12),
          _buildNotificationCard(
            leadingIcon: Icons.water_drop,
            title: 'Water your Aloe Vera!',
            subtitle: 'Last water time: 8 days ago\nSoil Moisture: 32%',
            trailingIcon: Icons.check_circle,
            trailingIconColor: Colors.black,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData leadingIcon,
    required String title,
    required String subtitle,
    IconData? trailingIcon,
    Color? trailingIconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      color: Colors.grey[100],
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(leadingIcon, color: Colors.black),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: trailingIcon != null
            ? Icon(trailingIcon, color: trailingIconColor, size: 24)
            : null,
      ),
    );
  }
}
