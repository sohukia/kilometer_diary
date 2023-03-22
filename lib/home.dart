import 'package:flutter/material.dart';
import 'package:kilometer_diary/create_data.dart';
import 'package:kilometer_diary/database/database_service.dart';

class HomePage extends StatefulWidget {
  final DatabaseService databaseService;
  const HomePage({super.key, required this.databaseService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async => print(
            await widget.databaseService.queryAllRows(),
          ),
          child: Text("GetValues"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addValue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addValue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDataPage(
          databaseService: widget.databaseService,
        ),
      ),
    );
  }

  Future<String> _loadValues() async {
    final result = await widget.databaseService.queryAllRows();
    return result[0]["date"];
  }
}
