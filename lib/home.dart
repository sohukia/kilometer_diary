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
        builder: (context) => const CreateDataPage(),
      ),
    );
  }
}
