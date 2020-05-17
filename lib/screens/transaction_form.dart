import 'dart:async';

import 'package:appbank/components/progress.dart';
import 'package:appbank/components/response_dialog.dart';
import 'package:appbank/components/transaction_auth_dialog.dart';
import 'package:appbank/http/webclients/transaction_webclient.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const String _newTransaction = 'Nova Transação';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    print("Transaction form Id: $transactionId");
    return Scaffold(
      appBar: AppBar(
        title: Text(_newTransaction),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Progress(message: 'Enviando...'),
                ),
                visible: false,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('TRANSFERIR'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                            onConfirm: (String password) {
                              _save(transactionCreated, password, context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    // Future.delayed(Duration(seconds: 1));
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );

    _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Transação conluída");
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpExcepiton).catchError((e) {
      _showFailureMessage(context, message: "TimeOut!");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    });
    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = "Erro Desconhecido"}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog("Erro Desconhecido!");
        });
  }
}
