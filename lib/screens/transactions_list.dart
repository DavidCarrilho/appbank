import 'package:appbank/components/centered_message.dart';
import 'package:appbank/components/progress.dart';
import 'package:appbank/http/webclients/transactions_webclient.dart';
import 'package:appbank/models/transaction.dart';
import 'package:flutter/material.dart';

const String _textTransactionList = "Lista de Transações";

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textTransactionList),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _webClient.finalAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(child: Progress());
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                          ),
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
                  );
                }
              }
              return CenteredMessage(
                "Nenhuma Transação !",
                icon: Icons.warning,
              );
              break;
          }
          return CenteredMessage(
            "Erro ao Carregar os Dados!",
            icon: Icons.signal_wifi_off,
          );
        },
      ),
    );
  }
}
