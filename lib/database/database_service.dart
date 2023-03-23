import 'package:kilometer_diary/database/kilometer_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseName = "kilometers.db";
  static const _databaseVersion = 1;

  static const table = "Kilometers";

  static const columnId = "id";
  static const columnValue = "value";
  static const columnDate = "date";

  late Database _database;

  Future<void> init() async {
    final documentDirectory = await getDatabasesPath();
    final path = join(documentDirectory, _databaseName);

    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnValue DOUBLE NOT NULL,
        $columnDate TEXT NOT NULL
      )
''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _database.insert(table, row);
  }

  Future<List<KilometerData>> queryAllRows() async {
    final result = await _database.query(table);
    List<KilometerData> rows = [];

    for (int i = 0; i < result.length; i++) {
      KilometerData data = KilometerData(
        id: int.parse(result[i]['id'].toString()),
        value: double.parse(result[i]['value'].toString()),
        date: DateTime.parse(result[i]['date'].toString()),
      );

      rows.add(data);
    }
    return rows;
  }

  Future<KilometerData> queryRow(int id) async {
    final row =
        await _database.rawQuery("SELECT * FROM $table WHERE $columnId = $id;");
    KilometerData result = KilometerData(
      id: id,
      value: double.parse(row[0]['value'].toString()),
      date: DateTime.parse(row[0]['date'].toString()),
    );
    return result;
  }

  Future<int> queryRowCount() async {
    final result = await _database.rawQuery("SELECT COUNT(*) FROM $table");
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _database.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _database.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
