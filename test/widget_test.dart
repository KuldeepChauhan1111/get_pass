import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_pass/features/auth/presentation/pages/login_screen.dart';

import 'package:get_pass/main.dart';

void main() {
  setUpAll(() async {
    await setupDi();
  });

  testWidgets('App opens on login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Login'), findsOneWidget);
  });
}
