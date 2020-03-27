import 'package:appbank/http/webclient.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/models/transaction.dart';
import 'package:appbank/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppBank());
  // finalAll().then((transactions) => print('new trasaction $transactions'));
  save(Transaction(200, Contact(0, 'Luarinha', 7000))).then((transaction) => print(transaction));
  // finalAll().then((transactions) => print('new trasaction $transactions'));
}
