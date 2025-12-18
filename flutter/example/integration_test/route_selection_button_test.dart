import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:flutter_ferrostar_example/main.dart';

import 'shared.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await ensureRustInitialized();
  });

  testWidgets('Route selection button loads a route without exceptions', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final routeButton = find.text('Route selection');
    expect(routeButton, findsOneWidget);

    await tester.tap(routeButton);
    await tester.pump();

    // Wait for routing to complete and geometry to render in UI.
    const maxWait = Duration(seconds: 90);
    final deadline = DateTime.now().add(maxWait);
    while (DateTime.now().isBefore(deadline)) {
      await tester.pump(const Duration(seconds: 1));
      final stepText = find.textContaining('Step ');
      if (stepText.evaluate().isNotEmpty) {
        break;
      }
    }

    expect(find.textContaining('Step '), findsOneWidget);
  });
}
