import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('Should display then main image when then Dashboard is opended',
          (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display then first feature when then Dashboard is opened',
          (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final fistFeature = find.byType(FeatureItem);
    expect(fistFeature, findsWidgets);
  });
}