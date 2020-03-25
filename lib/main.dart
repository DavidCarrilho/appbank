import 'package:appbank/database/app_database.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppBank());
  save(Contact(1, 'David', 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
}
