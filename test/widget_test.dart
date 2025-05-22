import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pfc_mobile/pages/edit_profile_screen.dart';
import 'package:pfc_mobile/pages/logout_screen.dart';
import 'package:pfc_mobile/pages/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen displays initial content', (WidgetTester tester) async {
    // Build the SettingsScreen widget
    await tester.pumpWidget(MaterialApp(
      home: SettingsScreen(),
      routes: {
        '/edit_profile': (context) => EditProfileScreen(),
        '/logout': (context) => LogoutScreen(),
      },
    ));

    // Verify that the settings title is displayed
    expect(find.text('Settings'), findsNWidgets(2)); // Once in AppBar, once in body

    // Verify that the options are displayed
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    // Test tapping Edit Profile
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Edit Profile'), findsNWidgets(2)); // Once in AppBar, once in body

    // Test tapping Log Out
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    expect(find.text('Logging out...'), findsOneWidget);
  });
}