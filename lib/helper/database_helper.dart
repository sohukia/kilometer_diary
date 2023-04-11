import 'package:kilometer_diary/models/db_km_data_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static const _databaseName = "kilometers.db";
  static const _databaseVersion = 1;

  static const kilometerTable = "Kilometers";

  static const columnId = "id";
  static const columnValue = "value";
  static const columnDate = "date";

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, _databaseName),
        onCreate: (db, version) {
      return db.execute('''
      CREATE TABLE $kilometerTable (
        $columnId INTEGER PRIMARY KEY,
        $columnValue DOUBLE NOT NULL,
        $columnDate TEXT NOT NULL
      );
''');
    }, version: _databaseVersion);
  }

  static Future<void> insert(String table, DBKilometerData data) async {
    final db = await DatabaseHelper.database();
    db.insert(table, data.toMap());
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DatabaseHelper.database();
    final result = await db.query(table);
    return result;
  }

  static Future<void> delete(String table, int id) async {
    final db = await DatabaseHelper.database();
    db.delete(table, where: "id = $id");
  }

  static Future<int> countValues(String table) async {
    final db = await DatabaseHelper.database();
    final result = await db.rawQuery("SELECT COUNT(*) FROM `$table`;");
    return sql.Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<void> clearTable(String table) async {
    final db = await DatabaseHelper.database();
    await db.execute('DELETE FROM `$table`;');
  }
}
