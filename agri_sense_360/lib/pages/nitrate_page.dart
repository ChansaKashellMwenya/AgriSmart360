import 'package:flutter/material.dart';

class NitratePage extends StatefulWidget {
  const NitratePage({Key? key}) : super(key: key);

  @override
  State<NitratePage> createState() => _NitratePageState();
}

class _NitratePageState extends State<NitratePage> {
  bool isWeekly = true;
  double nitrateLevel = 60; // ppm
  double nitrateTrend = 55; // ppm
  List<double> weeklyData = [40, 50, 45, 50, 60, 40, 55]; // Dummy data

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
              _buildNitrateLevel(),
              const SizedBox(height: 20),
              _buildTips(),
              const SizedBox(height: 20),
              _buildHistoryTabs(),
              const SizedBox(height: 20),
              _buildTrendSection(),
              const SizedBox(height: 20),
              _buildTrendGraph(),
            ],
          ),
        ),
      ),
    );
  }

  // Header with back button
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
              "Nitrate Monitoring",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  // Nitrate Level Section
  Widget _buildNitrateLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Nitrate Level",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              "${nitrateLevel.toInt()} ppm",
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: nitrateLevel / 100,
            minHeight: 8,
            backgroundColor: Colors.green[50],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        const SizedBox(height: 5),
        const Text("Caution",
            style: TextStyle(fontSize: 12, color: Colors.green)),
      ],
    );
  }

  // Tips Section
  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tips",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _tipCard("Avoid fertilizing today."),
        const SizedBox(height: 10),
        _tipCard("Try organic compost instead of urea."),
      ],
    );
  }

  // History Tabs
  Widget _buildHistoryTabs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("History",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _historyTab("Weekly", isWeekly, () {
                setState(() => isWeekly = true);
              }),
              _historyTab("Monthly", !isWeekly, () {
                setState(() => isWeekly = false);
              }),
            ],
          ),
        ),
      ],
    );
  }

  // Nitrate Trend Section
  Widget _buildTrendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nitrate Trend",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${nitrateTrend.toInt()} ppm",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Last 7 Days +5%",
                style: TextStyle(fontSize: 12, color: Colors.green)),
          ],
        ),
      ],
    );
  }

  // Nitrate Trend Graph + Days
  Widget _buildTrendGraph() {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: CustomPaint(
            painter: LineChartPainter(weeklyData),
            child: Container(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Mon"),
            Text("Tue"),
            Text("Wed"),
            Text("Thu"),
            Text("Fri"),
            Text("Sat"),
            Text("Sun"),
          ],
        ),
      ],
    );
  }

  // Tip Card Widget
  Widget _tipCard(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.eco, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  // History Tab Widget
  Widget _historyTab(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.black : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Line Chart
class LineChartPainter extends CustomPainter {
  final List<double> data;
  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (data.isNotEmpty) {
      double step = size.width / (data.length - 1);
      path.moveTo(0, size.height - data[0]);
      for (int i = 1; i < data.length; i++) {
        path.lineTo(step * i, size.height - data[i]);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
