import 'dart:convert';
import 'package:appbank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:appbank/http/webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> finalAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
