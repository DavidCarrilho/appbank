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
                _FeatureItem(
                  "Transferência",
                  Icons.monetization_on,
                  onClick: () {
                    _showContactList(context);
                  },
                ),
                _FeatureItem(
                  "Feed de Transações",
                  Icons.description,
                  onClick: () {
                    _showTransactionList(context);
                  },
                ),
                _FeatureItem(
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

  void _showTransactionList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }

  void _showContactList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactList()));
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  })  : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            height: 125,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
