import 'package:flutter/material.dart';

class KilometerListElement extends StatelessWidget {
  final int value;
  final String date;
  const KilometerListElement({
    super.key,
    required this.value,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(value.toString()),
      subtitle: Text(date),
    );
  }
}
