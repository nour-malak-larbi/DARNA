import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:darna_app/main.dart';
import 'package:darna_app/widgets/widgets.dart';

void main() {
  testWidgets('Authentication flow navigates Welcome -> Login -> Forgot Password -> Registration',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DarnaApp());
    await tester.pumpAndSettle();

    // Welcome screen
    expect(find.text('A little more calm.\nA lot more home.'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Log In'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // Login screen
    expect(find.text('Welcome back\nNour'), findsOneWidget);
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    // Forgot Password screen + sent state
    expect(find.text("Let's get you back in"), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'nour@darna.dz');
    await tester.tap(find.text('Send reset instructions'));
    await tester.pumpAndSettle();
    expect(find.text('Check your inbox'), findsOneWidget);

    // Back to Login -> Create an account
    await tester.scrollUntilVisible(
      find.text('Back to Log In'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Back to Log In'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('New to Darna? Create an account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New to Darna? Create an account'));
    await tester.pumpAndSettle();

    // Registration screen
    expect(find.text('Make room\nfor calm'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Darna UI kit showcase renders and handles interactions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: DarnaUiKitShowcase()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Darna / Reusable UI kit'), findsOneWidget);
    expect(find.byType(DarnaBottomNavBar), findsOneWidget);

    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Remaining unallocated'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Remaining unallocated'), findsOneWidget);
  });
}
