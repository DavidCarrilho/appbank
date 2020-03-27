import 'package:flutter/material.dart';

class ErrorLoading extends StatelessWidget {
  final String messageError;

  const ErrorLoading({this.messageError = "Erro ao Carregar os Dados!"});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.signal_wifi_off, size: 40, color: Theme.of(context).accentColor),
        SizedBox(height: 20),
        Text(
          messageError,
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18),
        ),
      ],
    ));
  }
}
