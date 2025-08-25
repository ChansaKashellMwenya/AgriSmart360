import 'package:flutter/material.dart';
import 'soil_page.dart';
import 'irrigation_page.dart';
import 'nitrate_page.dart';
import 'settings_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final Color primaryGreen = const Color(0xFF2F6B2F);

  final List<Widget> _pages = const [
    DashboardContent(),
    SoilPage(),
    IrrigationPage(),
    NitratePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Soil'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Irrigation'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Nitrate'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF2F6B2F);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Colors.black),
                const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 20),

            // Sections
            const SectionTitle(title: "Soil Health"),
            InfoCard(
              title: "Soil Health",
              subtitle: "Loam",
              description: "Moisture: 65% | pH: 6.8",
              buttonText: "Scan Soil",
              icon: Icons.camera_alt,
              color: primaryGreen,
            ),

            const SectionTitle(title: "Crop Recommendation"),
            InfoCard(
              title: "Top 3 Crops",
              subtitle: "Tomatoes, Peppers, Cucumbers",
              description: "Based on soil and weather conditions",
              buttonText: "View Crop Tips",
              icon: Icons.eco,
              color: primaryGreen,
            ),

            const SectionTitle(title: "Irrigation Status"),
            InfoCard(
              title: "Irrigation",
              subtitle: "Moisture: 65%",
              description: "Smart Mode: On | Last Watered: 2h ago",
              buttonText: "Water Now",
              icon: Icons.water_drop,
              color: primaryGreen,
            ),

            const SectionTitle(title: "Greenhouse"),
            InfoCard(
              title: "Greenhouse",
              subtitle: "Temp: 25°C | Humidity: 70% | CO₂: 400 ppm",
              description: "Optimal: Temp(20-30°C), Humidity(60-80%), CO₂(300-500ppm)",
              buttonText: "View Details",
              icon: Icons.thermostat,
              color: primaryGreen,
            ),

            const SectionTitle(title: "Nitrate Alert"),
            InfoCard(
              title: "Nitrate Level: 15 ppm",
              subtitle: "Status: Optimal",
              description: "",
              buttonText: "View Details",
              icon: Icons.science,
              color: primaryGreen,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.75,
              minHeight: 6,
              color: primaryGreen,
              backgroundColor: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),

            const SectionTitle(title: "Quick Actions"),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: const [
                QuickActionButton(text: "Scan Soil"),
                QuickActionButton(text: "Water Now"),
                QuickActionButton(text: "View Crop Tips"),
                QuickActionButton(text: "Connect Sensor"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title, subtitle, description, buttonText;
  final IconData icon;
  final Color color;

  const InfoCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[50],
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    onPressed: () {},
                    icon: Icon(icon, size: 16, color: color),
                    label: Text(buttonText, style: TextStyle(fontSize: 12, color: color)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 38, color: color)
          ],
        ),
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  final String text;
  const QuickActionButton({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF2F6B2F);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 0,
      ),
      onPressed: () {},
      child: Text(text, style: TextStyle(fontSize: 13, color: primaryGreen)),
    );
  }
} 