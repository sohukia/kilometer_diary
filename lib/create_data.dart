import 'package:flutter/material.dart';

class CreateDataPage extends StatefulWidget {
  const CreateDataPage({super.key});

  @override
  State<CreateDataPage> createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add data")),
    );
  }
}
