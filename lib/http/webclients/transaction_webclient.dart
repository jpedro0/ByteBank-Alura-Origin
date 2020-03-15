import 'package:bytebankorigin/http/webclient.dart';
import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/models/transaction.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client
        .post(
          baseUrl,
          headers: {'Content-type': 'application/json', 'password': '1000'},
          body: jsonEncode(_toTransactionMap(transaction)),
        )
        .timeout(Duration(seconds: 5));

    final Map<String, dynamic> transactionsJson = jsonDecode(response.body);

    return _toTransaction(transactionsJson, transactionsJson['contact']);
  }

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    return _toTransactions(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<Transaction> transactions = List();

    for (Map<String, dynamic> transactionsJson in jsonDecode(response.body)) {
      transactions.add(
        _toTransaction(
          transactionsJson,
          transactionsJson['contact'],
        ),
      );
    }
    return transactions;
  }

  Map<String, dynamic> _toTransactionMap(Transaction transaction) {
    final Contact contact = transaction.contact;
    return {
      'value': transaction.value,
      'contact': {
        'name': contact.name,
        'accountNumber': contact.accountNumber,
      }
    };
  }

  Transaction _toTransaction(
      Map<String, dynamic> transactionsJson, Map<String, dynamic> contactJson) {
    return Transaction(
      transactionsJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }
}
