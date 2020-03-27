import 'dart:convert';
import 'package:appbank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:appbank/http/webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> finalAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);
    return _toTransaction(response);
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodeJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }
}
