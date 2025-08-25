import 'package:flutter/material.dart';

// Import all pages
import 'pages/welcome_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/soil_page.dart';
import 'pages/irrigation_page.dart';
import 'pages/nitrate_page.dart';
import 'pages/settings_page.dart';
import 'pages/profile_page.dart'; // ✅ Added Profile Page

void main() {
  runApp(const AgriSense360App());
}

class AgriSense360App extends StatelessWidget {
  const AgriSense360App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriSense 360',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),

      // Start with Welcome Page
      initialRoute: '/welcome',

      routes: {
        // Welcome → Onboarding
        '/welcome': (context) => const WelcomePage(),
        '/onboarding': (context) => const OnboardingPage(),

        // Auth pages
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot': (context) => const ForgotPasswordPage(),

        // Dashboard
        '/dashboard': (context) => const DashboardPage(),

        // Additional pages
        '/soil': (context) => const SoilPage(),
        '/irrigation': (context) => const IrrigationPage(),
        '/nitrate': (context) => const NitratePage(),
        '/settings': (context) => const SettingsPage(),

        // ✅ New Profile page route
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
