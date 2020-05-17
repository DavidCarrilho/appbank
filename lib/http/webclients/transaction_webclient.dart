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

    await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpExcepiton(_getMessage(response.statusCode));
    // throw HttpExcepiton(_getMessage(500));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    } else {
      return "Erro Desconhecido!";
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "Informe um valor",
    401: "Falha na autenticação",
    409: "Transação já existe"
  };
}

class HttpExcepiton implements Exception {
  final String message;

  HttpExcepiton(this.message);
}
