import 'package:appbank/models/transaction.dart';
import 'package:flutter/material.dart';

const String _textTransactionList = "Lista de Transações";

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textTransactionList),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Transaction transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(
                transaction.value.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                transaction.contact.accountNumber.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
