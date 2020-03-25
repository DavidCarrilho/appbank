import 'package:appbank/components/contact_item.dart';
import 'package:appbank/models/contact.dart';
import 'package:appbank/screens/contact_fomr.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts = List();
  @override
  Widget build(BuildContext context) {
    contacts.add(Contact(0, "david", 1000));
    contacts.add(Contact(0, "david", 1000));
    contacts.add(Contact(0, "david", 1000));
    contacts.add(Contact(0, "david", 1000));
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Contact contact = contacts[index];
          return ContactItem(contact);
        },
        itemCount: contacts.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then((newContact) => debugPrint(newContact.toString()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
