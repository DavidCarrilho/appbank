import 'package:appbank/http/webclient.dart';
import 'package:appbank/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppBank());
  finalAll().then((transactions) => print('new trasaction $transactions'));
}
