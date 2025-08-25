import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'forgot_password_page.dart';
import 'sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color primaryGreen = const Color(0xFF2F6B2F);
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Dummy data
  String fullName = "John Doe";
  String email = "johndoe@example.com";
  String phone = "+260 971 234 567";
  String farmName = "Green Valley Farm";
  String location = "Unknown";
  String farmSize = "5 Hectares";
  String soilType = "Not linked";
  String irrigationType = "Not linked";
  String preferredCrops = "Tomatoes, Peppers";
  String currentCrops = "Maize, Beans";
  String cropHistory = "Wheat (2023), Soybeans (2022)";

  // Show bottom sheet for options
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Cancel"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  // Pick image from selected source
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Edit fields manually
  void _editField(String title, String currentValue, Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(controller: controller, decoration: InputDecoration(labelText: title)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () { onSave(controller.text); Navigator.pop(context); }, child: const Text("Save")),
        ],
      ),
    );
  }

  // Fetch GPS location
  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enable location services")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location permission denied")));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location permission permanently denied")));
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      location = "Lat: ${pos.latitude}, Lon: ${pos.longitude}";
    });
  }

  // Dummy method: Link sensors/devices
  void _linkDevices() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Searching for devices...")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), backgroundColor: primaryGreen, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture with camera/gallery options
            GestureDetector(
              onTap: _showImageSourceSheet,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
              ),
            ),
            const SizedBox(height: 12),
            Text(fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),

            // Profile Info Cards
            ProfileInfoCard(icon: Icons.phone, title: "Phone Number", subtitle: phone, onTap: () => _editField("Phone Number", phone, (val) => setState(() => phone = val))),
            ProfileInfoCard(icon: Icons.home_work, title: "Farm Name", subtitle: farmName, onTap: () => _editField("Farm Name", farmName, (val) => setState(() => farmName = val))),
            ProfileInfoCard(icon: Icons.location_on, title: "Farm Location", subtitle: location, onTap: _getLocation),
            ProfileInfoCard(icon: Icons.agriculture, title: "Farm Size", subtitle: farmSize, onTap: () => _editField("Farm Size", farmSize, (val) => setState(() => farmSize = val))),
            ProfileInfoCard(icon: Icons.landscape, title: "Soil Type (Sensor)", subtitle: soilType, onTap: _linkDevices),
            ProfileInfoCard(icon: Icons.water, title: "Irrigation Type (Sensor)", subtitle: irrigationType, onTap: _linkDevices),
            ProfileInfoCard(icon: Icons.eco, title: "Preferred Crops", subtitle: preferredCrops, onTap: () => _editField("Preferred Crops", preferredCrops, (val) => setState(() => preferredCrops = val))),
            ProfileInfoCard(icon: Icons.grass, title: "Current Season Crops", subtitle: currentCrops, onTap: () => _editField("Current Crops", currentCrops, (val) => setState(() => currentCrops = val))),
            ProfileInfoCard(icon: Icons.history, title: "Crop History (Auto)", subtitle: cropHistory, onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Crop history is auto-generated")));
            }),

            const SizedBox(height: 20),

            // Link IoT Devices
            ElevatedButton.icon(
              onPressed: _linkDevices,
              icon: const Icon(Icons.sensors, color: Colors.white),
              label: const Text("Link Sensors & Devices", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, minimumSize: const Size(double.infinity, 48)),
            ),
            const SizedBox(height: 10),

            // Change Password
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage())),
              icon: const Icon(Icons.lock_reset, color: Colors.white),
              label: const Text("Change Password", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, minimumSize: const Size(double.infinity, 48)),
            ),
            const SizedBox(height: 10),

            // Logout
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage())),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Logout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, minimumSize: const Size(double.infinity, 48)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileInfoCard({Key? key, required this.icon, required this.title, required this.subtitle, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF2F6B2F);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: primaryGreen),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}
