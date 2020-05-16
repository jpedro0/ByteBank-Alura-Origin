import 'package:bytebankorigin/main.dart';
import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/screens/contact/form.dart';
import 'package:bytebankorigin/screens/contact/list.dart';
import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a contect', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContectsList);
    expect(contactsList, findsOneWidget);
    
    verify(mockContactDao.findAll()).called(1);
    
    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) =>
        textFieldByLabelMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Alex');

    final accountNameTextField = find.byWidgetPredicate((widget) =>
        textFieldByLabelMatcher(widget, 'Account number'));
    expect(accountNameTextField, findsOneWidget);
    await tester.enterText(accountNameTextField, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(0, 'Alex', 1000)));

    final contactsListBack = find.byType(ContectsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}
