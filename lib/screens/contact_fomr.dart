import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
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
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                  ),
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
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
                  onPressed: () {},
                  child: Text("Criar"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
