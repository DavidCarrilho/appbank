import 'package:appbank/components/contact_item.dart';
import 'package:appbank/components/progress.dart';
import 'package:appbank/database/dao/contact_dao.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/screens/contact_fomr.dart';
import 'package:flutter/material.dart';

const String _textContact = "Lista de Transferência";
const String _textErrorContact = "Erro ao Carregar";

class ContactList extends StatelessWidget {
  final ContactDAO _dao = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textContact),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1)).then((value) => _dao.findAll()) ,
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
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return ContactItem(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text(_textErrorContact);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
