import 'package:bytebankorigin/models/transaction.dart';
import 'package:bytebankorigin/http/webclient.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client
        .post(
          baseUrl,
          headers: {'Content-type': 'application/json', 'password': '1000'},
          body: jsonEncode(transaction.toJson()),
        )
        .timeout(Duration(seconds: 5));

    return Transaction.fromJson(jsonDecode(response.body));
  }

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }
}
