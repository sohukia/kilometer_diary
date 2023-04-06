import 'package:flutter/material.dart';
import 'package:kilometer_diary/models/kilometer_data_model.dart';
import 'package:kilometer_diary/services/kilometers_service.dart';
import 'package:kilometer_diary/widgets/kilometer_list_element.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _kilometersValueController =
      TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final KilometersService _kilometersService = KilometersService();

  double totalRun = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kilometer Diary"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.remove))],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _kilometersValueController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.amber,
                    ),
                  ),
                  labelText: "Kilometers",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber),
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Date : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
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
                      child: const Text("Select"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                  future: KilometersService().fetchTotal(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("Total distance : $totalRun km");
                    } else {
                      return const Text("No runs yet !");
                    }
                  }),
            ),
            Expanded(
              child: FutureBuilder(
                future: _kilometersService.fetchKilometers(),
                builder: (context, snapshot) {
                  List<KilometerData>? kilometers = snapshot.data;
                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                            'No data found. Start by pressing + button !'));
                  } else {
                    return Card(
                      child: ListView.builder(
                        itemCount: kilometers?.length,
                        itemBuilder: (context, index) {
                          final kilometer = kilometers![index];

                          return KilometerListElement(kilometerData: kilometer);
                        },
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          if (_kilometersValueController.text != "") {
            _kilometersService.saveKilometers(
              double.parse(_kilometersValueController.text),
              _selectedDate,
            );
            _kilometersValueController.clear();
            _selectedDate = DateTime.now();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fill with value !'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
