import 'dart:convert';

import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/models/transaction.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'http://192.168.0.57:8080/transactions';

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
