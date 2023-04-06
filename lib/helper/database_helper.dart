import 'package:kilometer_diary/models/kilometer_data_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static const _databaseName = "kilometers.db";
  static const _databaseVersion = 1;

  static const table = "Kilometers";

  static const columnId = "id";
  static const columnValue = "value";
  static const columnDate = "date";

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, _databaseName),
        onCreate: (db, version) {
      return db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnValue DOUBLE NOT NULL,
        $columnDate TEXT NOT NULL
      ); 
      CREATE TABLE Total (
        id INTEGER PRIMARY KEY,
        value DOUBLE NOT NULL
      );
''');
    }, version: 1);
  }

  static Future<void> insert(String table, KilometerData data) async {
    final db = await DatabaseHelper.database();
    db.insert(table, data.toMap());
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DatabaseHelper.database();
    final result = await db.query(table);
    return result;
  }

  static Future<int> countValues(String table) async {
    final db = await DatabaseHelper.database();
    final result = await db.rawQuery("SELECT COUNT(*) FROM $table");
    return sql.Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<void> clearTable(String table) async {
    final db = await DatabaseHelper.database();
    return db.execute('TRUNCATE ');
  }
}
