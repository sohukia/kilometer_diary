import 'package:kilometer_diary/generator/id_generator.dart';
import 'package:kilometer_diary/helper/database_helper.dart';
import 'package:kilometer_diary/models/kilometer_data_model.dart';

class KilometersService {
  void saveKilometers(double value, DateTime date) {
    DatabaseHelper.insert(
      'kilometers',
      KilometerData(id: IdGenerator().generateId(), value: value, date: date),
    );
  }

  Future<double> fetchTotal() async {
    final totalList = await DatabaseHelper.getData('Total');
    if (await DatabaseHelper.countValues('Total') != 0) {
      return double.parse(totalList.elementAt(0)['value'].toString());
    } else {
      return 0;
    }
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
}
