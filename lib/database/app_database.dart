import 'package:appbank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'appbank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete, // Para fazer a limpeza do db
  );
}
