import 'package:appbank/components/centered_message.dart';
import 'package:appbank/components/contact_item.dart';
import 'package:appbank/components/progress.dart';
import 'package:appbank/database/dao/contact_dao.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/screens/contact_form.dart';
import 'package:appbank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

const String _textContact = "Lista de Contatos";
const String _textErrorContact = "Erro ao Carregar";

class ContactsList extends StatelessWidget {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_textContact),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 2))
            .then((value) => _dao.findAll()),
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
                final List<Contact> contacts = snapshot.data;
                if (contacts.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Contact contact = contacts[index];
                      return ContactItem(contact, onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TransactionForm(contact)));
                      });
                    },
                    itemCount: contacts.length,
                  );
                }
              }
              return CenteredMessage(
                "Nenhum Contato!",
                icon: Icons.person_add,
              );
              break;
          }
          return CenteredMessage(
            "Erro ao Carregar os Dados!",
            icon: Icons.signal_wifi_off,
          );
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
