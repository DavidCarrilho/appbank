import 'package:appbank/components/feature_item.dart';
import 'package:appbank/screens/contacts_list.dart';
import 'package:appbank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

const _textHome = "Dashboard";
const _imgHome = "images/home.jpg";

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dashboard),
        title: Text(_textHome),
        centerTitle: true,
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              child: Image.asset(_imgHome),
            ),
          ),
          Container(
            height: 125,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FeatureItem(
                  "Contatos",
                  Icons.supervised_user_circle,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                FeatureItem(
                  "Feed de Transações",
                  Icons.description,
                  onClick: () {
                    _showTransactionsList(context);
                  },
                ),
                FeatureItem(
                  "Exemplo",
                  Icons.android,
                  onClick: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}
