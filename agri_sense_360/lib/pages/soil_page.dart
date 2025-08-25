import 'package:flutter/material.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({Key? key}) : super(key: key);

  @override
  _SoilPageState createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  // Replace these dummy sensor values with real-time data later
  double nitrogen = 15;
  double phosphorus = 10;
  double potassium = 5;

  @override
  Widget build(BuildContext context) {
    // Generate fertilizer recommendations dynamically
    List<Map<String, dynamic>> recommendations = _getFertilizerRecommendations(
      nitrogen: nitrogen,
      phosphorus: phosphorus,
      potassium: potassium,
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Soil & Crop Recommendation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Live Sensor Panel
            const Text("Live Sensor Panel",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                const SensorCard(title: "pH", value: "6.5"),
                const SensorCard(title: "Moisture", value: "20%"),
                SensorCard(title: "Nitrogen", value: "$nitrogen ppm"),
                SensorCard(title: "Phosphorus", value: "$phosphorus ppm"),
                SensorCard(title: "Potassium", value: "$potassium ppm"),
              ],
            ),
            const SizedBox(height: 20),

            // AI-Based Crop Suggestions
            const Text("AI-Based Crop Suggestions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Row(
              children: const [
                Expanded(
                  child: CropSuggestionCard(
                    cropName: "Maize",
                    soilMatch: "Soil Match: 90%, Water Need: Moderate",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CropSuggestionCard(
                    cropName: "Groundnuts",
                    soilMatch: "Soil Match: 85%, Water Need: Moderate",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Fertilizer Plan (Dynamic)
            const Text("Fertilizer Plan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              "Based on current NPK levels, here are the recommended fertilizers:",
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),

            Column(
              children: recommendations.map((rec) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FertilizerCard(
                    title: rec['title'],
                    description: rec['description'],
                    icon: rec['icon'],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Scan Soil Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text("Scan Soil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fertilizer Recommendation Logic
  List<Map<String, dynamic>> _getFertilizerRecommendations({
    required double nitrogen,
    required double phosphorus,
    required double potassium,
  }) {
    List<Map<String, dynamic>> recs = [];

    if (nitrogen < 20) {
      recs.add({
        'title': "Urea",
        'description': "Apply 20 kg/ha of Urea to boost Nitrogen levels",
        'icon': Icons.spa,
      });
    }

    if (phosphorus < 15) {
      recs.add({
        'title': "DAP Fertilizer",
        'description': "Apply 25 kg/ha of DAP for Phosphorus",
        'icon': Icons.grass,
      });
    }

    if (potassium < 10) {
      recs.add({
        'title': "MOP Fertilizer",
        'description': "Apply 15 kg/ha of MOP for Potassium",
        'icon': Icons.eco,
      });
    }

    if (nitrogen >= 20 && phosphorus >= 15 && potassium >= 10) {
      recs.add({
        'title': "NPK 15-15-15",
        'description': "Balanced soil nutrition maintained",
        'icon': Icons.agriculture,
      });
    }

    return recs;
  }
}

// ------------------ Reusable Widgets ------------------
class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  const SensorCard({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CropSuggestionCard extends StatelessWidget {
  final String cropName;
  final String soilMatch;
  const CropSuggestionCard({
    required this.cropName,
    required this.soilMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.agriculture, size: 40, color: Colors.green[700]),
          const SizedBox(height: 6),
          Text(cropName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(soilMatch,
              style: const TextStyle(fontSize: 12, color: Colors.green)),
        ],
      ),
    );
  }
}

class FertilizerCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  const FertilizerCard({
    required this.title,
    required this.description,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.green[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(fontSize: 12, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
