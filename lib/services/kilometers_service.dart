import 'package:kilometer_diary/generator/id_generator.dart';
import 'package:kilometer_diary/helper/database_helper.dart';
import 'package:kilometer_diary/models/db_km_data_model.dart';
import 'package:kilometer_diary/models/kilometer_data_model.dart';

class KilometersService {
  void saveKilometers(double value, DateTime date) {
    DatabaseHelper.insert(
      'kilometers',
      DBKilometerData(
          id: IdGenerator().generateId(),
          value: value,
          date: date.toIso8601String()),
    );
  }

  Future<List<KilometerData>> fetchKilometers() async {
    final kilometersList = await DatabaseHelper.getData('kilometers');
    return kilometersList
        .map(
          (item) => KilometerData(
            id: int.parse(item['id'].toString()),
            value: double.parse(item['value'].toString()),
            date: DateTime.parse(item['date'].toString()),
          ),
        )
        .toList();
  }

  Future<double> calcTotalDistance() async {
    final List<KilometerData> kilometers = await fetchKilometers();
    double sum = 0.0;
    for (int i = 0; i < kilometers.length; i++) {
      sum += kilometers[i].value;
    }
    return sum;
  }

  Future<void> deleteData(int id) async {
    DatabaseHelper.delete("kilometers", id);
  }
}
