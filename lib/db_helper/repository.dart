import 'database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection con = DatabaseConnection();
  Repository() {
    con = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await con.setDatabase();
      return _database;
    }
  }

  saveUserInfo(String token, String name, int role, int isactive) async {
    var connection = await database;
    String sql = """INSERT INTO user_info (token,name,role,isactive) VALUES (
      '$token',
      '$name',
      $role,
      $isactive
    ); """;
    return await connection?.rawInsert(sql);
  }

  readUserInfo() async {
    var connection = await database;
    String sql = """
      SELECT token,name,role FROM user_info WHERE isactive = 1;
    """;
    return connection?.rawQuery(sql);
  }
}
