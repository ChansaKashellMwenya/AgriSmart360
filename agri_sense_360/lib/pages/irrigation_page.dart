import 'package:flutter/material.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({Key? key}) : super(key: key);

  @override
  State<IrrigationPage> createState() => _IrrigationPageState();
}

class _IrrigationPageState extends State<IrrigationPage> {
  bool autoMode = true;
  bool valveStatus = false;
  bool fans = false;
  bool sprinklers = false;
  bool vents = false;

  Color get primaryGreen => const Color(0xFF2F6B2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildMoistureOverview(),
              const SizedBox(height: 20),
              _buildIrrigationMode(),
              const SizedBox(height: 20),
              _buildValveStatus(),
              const SizedBox(height: 20),
              _buildGreenhouseSensors(),
              const SizedBox(height: 20),
              _buildToggles(),
            ],
          ),
        ),
      ),
    );
  }

  /// Header Section
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Irrigation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  /// Moisture Overview Section
  Widget _buildMoistureOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Moisture Overview",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "Current Soil Moisture\n\n68%",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _InfoColumn(title: "Last Irrigation", value: "2 days ago, 10:30 AM"),
            _InfoColumn(title: "Forecasted Rainfall", value: "0.2 inches"),
          ],
        ),
      ],
    );
  }

  /// Irrigation Mode Section
  Widget _buildIrrigationMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Irrigation Mode",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _modeCard(
          title: "Auto Mode",
          description: "Controls valves based on sensor data",
          selected: autoMode,
          onTap: () => setState(() => autoMode = true),
        ),
        const SizedBox(height: 10),
        _modeCard(
          title: "Manual Mode",
          description: "Manually toggle valve ON/OFF",
          selected: !autoMode,
          onTap: () => setState(() => autoMode = false),
        ),
      ],
    );
  }

  Widget _modeCard({
    required String title,
    required String description,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: selected ? primaryGreen : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(fontSize: 12, color: primaryGreen)),
              ],
            ),
            Icon(Icons.radio_button_checked,
                color: selected ? primaryGreen : Colors.grey)
          ],
        ),
      ),
    );
  }

  /// Valve Status Section
  Widget _buildValveStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Valve Status",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Switch(
          value: valveStatus,
          activeColor: primaryGreen,
          onChanged: (val) => setState(() => valveStatus = val),
        ),
      ],
    );
  }

  /// Greenhouse Sensors Section
  Widget _buildGreenhouseSensors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Greenhouse Sensors",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _sensorCard("Temperature", "24°C"),
            _sensorCard("Humidity", "72%"),
            _sensorCard("CO₂ Levels", "450 ppm", fullWidth: true),
          ],
        ),
      ],
    );
  }

  Widget _sensorCard(String title, String value, {bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : 150,
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
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// Toggles for Fans, Sprinklers, Vents
  Widget _buildToggles() {
    return Column(
      children: [
        _toggleRow("Fans", fans, (val) => setState(() => fans = val)),
        _toggleRow("Sprinklers", sprinklers, (val) => setState(() => sprinklers = val)),
        _toggleRow("Vents", vents, (val) => setState(() => vents = val)),
      ],
    );
  }

  Widget _toggleRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Switch(
          value: value,
          activeColor: primaryGreen,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// Reusable widget for Info Column
class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.green)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
