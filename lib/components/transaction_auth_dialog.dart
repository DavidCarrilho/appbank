import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Autenticar"),
      content: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.number,
        obscureText: true,
        autofocus: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 50, letterSpacing: 28),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text("Confirmar"),
        ),
      ],
    );
  }
}
