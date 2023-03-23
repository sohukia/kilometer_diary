import 'package:flutter/material.dart';
import 'package:kilometer_diary/database/kilometer_data_model.dart';

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
    );
  }
}
