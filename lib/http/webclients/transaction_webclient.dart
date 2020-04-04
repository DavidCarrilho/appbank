import 'dart:convert';
import 'package:appbank/http/webclient.dart';
import 'package:appbank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 400) {
      throw Exception("Ocorreu um erro aqui submit trasanction");
    } 
    if (response.statusCode == 401) {
      throw Exception("Falha na autenticação");
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
