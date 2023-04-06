import 'package:flutter/material.dart';
import 'package:kilometer_diary/models/kilometer_data_model.dart';

class UnitKilometerDataPage extends StatelessWidget {
  final KilometerData data;

  const UnitKilometerDataPage({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.id.toString()),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => _delete(),
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete() async {}
}
