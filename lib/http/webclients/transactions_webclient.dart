import 'dart:convert';
import 'package:appbank/models/contact.dart';
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
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);
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
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodeJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }
}
