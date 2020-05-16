import 'package:bytebankorigin/main.dart';
import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/screens/contact/list.dart';
import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:bytebankorigin/screens/transaction_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
    
    when(mockContactDao.findAll()).thenAnswer((invocation) async {
      return [Contact(0, 'Alex', 1000)];
    });

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContectsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Alex' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);
    
  });
}
