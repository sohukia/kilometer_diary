import 'package:flutter/material.dart';
import 'package:kilometer_diary/create_data.dart';
import 'package:kilometer_diary/database/database_service.dart';
import 'package:kilometer_diary/database/kilometer_data_model.dart';
import 'package:kilometer_diary/widgets/kilometer_list_element.dart';

class HomePage extends StatefulWidget {
  final DatabaseService databaseService;
  const HomePage({super.key, required this.databaseService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    width: width,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          KilometerListElement(
                        kilometerData: snapshot.data![index],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addValue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<KilometerData>> _fetchData() async =>
      await widget.databaseService.queryAllRows();

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
}
