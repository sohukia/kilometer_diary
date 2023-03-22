import 'package:flutter/material.dart';
import 'package:kilometer_diary/database/database_service.dart';
import 'package:kilometer_diary/home.dart';

final databaseService = DatabaseService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage(
        databaseService: databaseService,
      ),
    );
  }
}
