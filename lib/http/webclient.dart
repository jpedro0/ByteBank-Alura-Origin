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

Future<List<Transaction>> findAll() async {
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionsJSON
      in jsonDecode(await _getTransactions())) {
    final Map<String, dynamic> contactJSON = transactionsJSON['contact'];
    transactions.add(
      Transaction(
        transactionsJSON['value'],
        Contact(0, contactJSON['name'], contactJSON['accountNumber']),
      ),
    );
  }
  return transactions;
}

Future<String> _getTransactions() async {
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  return await client
      .get('http://192.168.0.57:8080/transactions')
      .timeout(Duration(seconds: 5))
      .then((item) => item.body);
}
