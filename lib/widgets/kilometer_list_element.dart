import 'package:flutter/material.dart';
import 'package:kilometer_diary/models/kilometer_data_model.dart';
import 'package:kilometer_diary/pages/unit_kilometer_data_page.dart';

class KilometerListElement extends StatelessWidget {
  final KilometerData kilometerData;
  const KilometerListElement({
    super.key,
    required this.kilometerData,
  });

  @override
  Widget build(BuildContext context) {
    final value = kilometerData.value.toString();
    final date = kilometerData.date;
    return ListTile(
      title: Text(value),
      subtitle: Text("On ${date.day}/${date.month}/${date.year}"),
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UnitKilometerDataPage(data: kilometerData),
          ),
        );
      },
    );
  }
}
