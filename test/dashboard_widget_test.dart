import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('Should display then main image when then Dashboard is opended',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Should display then transfer feature when then Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display then transaction feature when then Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));
    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}
