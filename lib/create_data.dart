import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kilometer_diary/database/database_service.dart';
import 'package:kilometer_diary/database/kilometer_data_model.dart';
import 'package:kilometer_diary/home.dart';

class CreateDataPage extends StatefulWidget {
  final DatabaseService databaseService;
  const CreateDataPage({super.key, required this.databaseService});

  @override
  State<CreateDataPage> createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {
  DateTime _selectedDate = DateTime.now();
  double _distance = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add data")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Distance : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 4),
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                        ],
                        onChanged: (value) => _distance = double.parse(value),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Date : ",
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (newDate == null) return;
                        setState(() => _selectedDate = newDate);
                      },
                      child: Text(
                          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    final db = widget.databaseService;
                    final data = KilometerData(
                      id: await db.queryRowCount() + 1,
                      value: _distance,
                      date: _selectedDate,
                    );

                    await db
                        .insert(data.toMap())
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
