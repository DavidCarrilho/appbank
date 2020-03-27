import 'dart:convert';

import 'package:appbank/models/contact.dart';
import 'package:appbank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = "http://192.168.0.116:8080/transactions";

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print("url: ${data.url}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }
}

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

Future<List<Transaction>> finalAll() async {
  final Response response =
      await client.get(baseUrl).timeout(Duration(seconds: 10));
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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson);
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
