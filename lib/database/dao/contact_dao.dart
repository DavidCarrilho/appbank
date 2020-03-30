import 'package:appbank/database/app_database.dart';
import 'package:appbank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}


// import 'package:sqflite/sqlite_api.dart';

// class ContactDao {
//   static const String tableSql = '''
//     'CREATE TABLE $_tableName('
//           '$_id INTEGER PRIMARY KEY, '
//           '$_name TEXT, '
//           '$_accountNumber INTEGER)'
//    ''';

//   static const String _tableName = 'contacts';
//   static const String _id = 'id';
//   static const String _name = 'name';
//   static const String _accountNumber = 'account_number';

//   Future<int> save(Contact contact) async {
//     final Database db = await getDatabase();
//     return _toMap(contact, db);
//   }

//   Future<List<Contact>> findAll() async {
//     final Database db = await getDatabase();
//     // final List<Map<String, dynamic>> result = await db.query('contacts');
//     List<Contact> contacts = await _toList(db);
//     return contacts;
//   }

//   Future<int> _toMap(Contact contact, Database db) {
//     final Map<String, dynamic> contactMap = Map();
//     contactMap[_name] = contact.name;
//     contactMap[_accountNumber] = contact.accountNumber;
//     return db.insert(_tableName, contactMap);
//   }

//   Future<List<Contact>> _toList(Database db) async {
//     final List<Contact> contacts = List();
//     for (Map<String, dynamic> row in await db.query(_tableName)) {
//       final Contact contact = Contact(
//         row[_id],
//         row[_name],
//         row[_accountNumber],
//       );
//       contacts.add(contact);
//     }
//     return contacts;
//   }
// }
