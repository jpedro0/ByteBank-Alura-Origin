import 'package:bytebankorigin/models/transaction.dart';
import 'package:bytebankorigin/http/webclient.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client
        .post(
          baseUrl,
          headers: {'Content-type': 'application/json', 'password': password},
          body: jsonEncode(transaction.toJson()),
        );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed'
  };

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
