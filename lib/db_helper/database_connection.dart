import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'LANBOOK');
    var database = await openDatabase(
      path,
      version: 3,
      onCreate: _createDb,
      onUpgrade: _upgradeDb,
    );
    return database;
  }

  Future<void> _createDb(Database database, int version) async {
    String userInfoTable = """
      CREATE TABLE user_info (
        id INTERGER PRIMARY KEY, 
        token TEXT,
        name TEXT,
        role INTEGER,
        isactive INTEGER
      );
    """;
    await database.execute(userInfoTable);
  }

  Future<void> _upgradeDb(
      Database database, int oldVersion, int newVersion) async {
    String dropUserInfoTable = """
      DROP TABLE user_info;
    """;
    await database.execute(dropUserInfoTable);

    String userInfoTable = """
      CREATE TABLE user_info (
        id INTERGER PRIMARY KEY,
        email TEXT,
        password TEXT,
        token TEXT,
        name TEXT,
        role INTEGER,
        isactive INTEGER
      );
    """;
    await database.execute(userInfoTable);
  }
}
