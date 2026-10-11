import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testdrive/main.dart';

void main() {
  testWidgets('event page shows details and responds to selections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text("Yesterday's"), findsOneWidget);
    expect(find.text('DJ Smooth'), findsOneWidget);

    await tester.tap(find.byTooltip('Add favorite'));
    await tester.pump();
    expect(find.byTooltip('Remove favorite'), findsOneWidget);

    await tester.ensureVisible(find.text('Beer'));
    await tester.tap(find.text('Beer'));
    await tester.pump();
    expect(find.text('Showing Beer'), findsOneWidget);

    await tester.ensureVisible(find.text('Find a Safe Ride'));
    await tester.tap(find.text('Find a Safe Ride'));
    await tester.pump();
    expect(find.text('Safe ride options are coming up.'), findsOneWidget);
  });
}
