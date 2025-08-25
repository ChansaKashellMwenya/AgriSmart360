import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Color get primaryGreen => const Color(0xFF2F6B2F);
  Color get cardBg => Colors.white;
  Color get softShadow => const Color(0x1A000000); // 10% black

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Account'),
            _settingsCard([
              _settingsTile(
                icon: Icons.person_outline,
                title: 'Profile',
                onTap: () {
                  Navigator.pushNamed(context, '/profile'); // ✅ Navigate to Profile
                },
              ),
              _settingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.pushNamed(context, '/forgot'); // ✅ Navigate to Forgot Password page
                },
              ),
            ]),
            const SizedBox(height: 16),

            _sectionTitle('Preferences'),
            _settingsCard([
              _settingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: primaryGreen,
                ),
              ),
              _settingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: false,
                  onChanged: (val) {},
                  activeColor: primaryGreen,
                ),
              ),
            ]),
            const SizedBox(height: 16),

            _sectionTitle('About'),
            _settingsCard([
              _settingsTile(
                icon: Icons.info_outline,
                title: 'About App',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('About app info coming soon')),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy policy coming soon')),
                  );
                },
              ),
            ]),
            const SizedBox(height: 16),

            _signOutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      );

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: softShadow,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      );

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: _cardDecoration,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryGreen),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _signOutButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
        },
        icon: const Icon(Icons.logout),
        label: const Text('Sign Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 48, 114, 82),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
