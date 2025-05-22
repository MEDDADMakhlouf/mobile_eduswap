import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pfc_mobile/pages/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays initial content', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    // Verify that the welcome text is displayed
    expect(find.text('Welcome Back!'), findsOneWidget);

    // Verify that the notifications section is displayed
    expect(find.text('New Notifications'), findsOneWidget);
    expect(find.text('Notification 1: Prof. Smith'), findsOneWidget);
    expect(find.text('Notification 2: Prof. Jones'), findsOneWidget);

    // Verify that the timetable section is displayed
    expect(find.text('Your Timetable'), findsOneWidget);
    expect(find.text('9:00 AM'), findsOneWidget);
    expect(find.text('Math'), findsOneWidget);
  });
}