import 'package:bytebankorigin/main.dart';
import 'package:bytebankorigin/screens/contact/form.dart';
import 'package:bytebankorigin/screens/contact/list.dart';
import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should save a contect', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();
    final contactsList = find.byType(ContectsList);
    expect(contactsList, findsOneWidget);
    
    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget){
      if(widget is TextField){
          return widget.decoration.labelText == 'Full name';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Alex');

    final accountNameTextField = find.byWidgetPredicate((widget){
      if(widget is TextField){
        return widget.decoration.labelText == 'Account number';
      }
      return false;
    });
    expect(accountNameTextField, findsOneWidget);
    await tester.enterText(accountNameTextField, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContectsList);
    expect(contactsListBack, findsOneWidget);
  });
}
