import 'package:appbank/database/dao/contact_dao.dart';
import 'package:appbank/models/contact.dart';
import 'package:flutter/material.dart';

const String _textNewContact = "Novo Contato";
const String _labelContact = "Nome Completo";
const String _labelAccountNumber = "Número da Conta";

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textNewContact),
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
                    labelText: _labelContact,
                  ),
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: _labelAccountNumber,
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
                    _dao.save(newContact).then((id) => Navigator.pop(context));
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
