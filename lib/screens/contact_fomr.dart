import 'package:appbank/database/app_database.dart';
import 'package:appbank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Contato"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                  ),
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Número da Conta",
                  ),
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                // width: double.maxFinite,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber =
                        int.tryParse(_accountNumberController.text);
                    final Contact newContact = Contact(0, name, accountNumber);
                    save(newContact)
                        .then((id) => Navigator.pop(context));
                  },
                  child: Text("CRIAR"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
