import 'package:appbank/screens/contacts_list.dart';
import 'package:appbank/screens/dashboard.dart';
import 'package:flutter/material.dart';

class AppBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.lightBlue[900],
          accentColor: Colors.cyan[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.cyan[700],
              textTheme: ButtonTextTheme.primary)),
      home: ContactList(),
    );
  }
}
