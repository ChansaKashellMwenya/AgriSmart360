import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agri_sense_360/main.dart';

/// Helper: waits until widget appears or times out with logs
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  final maxTries = (timeout.inMilliseconds / 100).round();
  for (int i = 0; i < maxTries; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      debugPrint("✅ Found widget: ${finder.toString()}");
      return;
    }
  }
  throw Exception("❌ Widget not found: ${finder.toString()}");
}

void main() {
  testWidgets('AgriSense360 loads and navigates through main screens',
      (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const AgriSense360App());
    await tester.pumpAndSettle();

    // --- Welcome Page ---
    final getStartedBtn = find.text('Get Started');
    await pumpUntilFound(tester, getStartedBtn);
    await tester.tap(getStartedBtn);
    await tester.pumpAndSettle();

    // --- Onboarding Pages ---
    for (int i = 0; i < 2; i++) {
      final nextBtn = find.text('Next');
      await pumpUntilFound(tester, nextBtn);
      await tester.tap(nextBtn);
      await tester.pumpAndSettle();
    }

    // --- Final Continue Button ---
    final continueBtn = find.text('Continue');
    await pumpUntilFound(tester, continueBtn);
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();

    // --- Verify Sign In Page ---
    final signInTitle = find.text('Sign In');
    await pumpUntilFound(tester, signInTitle);
    expect(signInTitle, findsOneWidget);
  });
}
