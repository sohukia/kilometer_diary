class KilometerData {
  final int id;
  final double value;
  final DateTime date;

  KilometerData({
    required this.id,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "date": date.toString(),
      };

  @override
  String toString() {
    return "KilometerData{id: $id, value: $value, date: $date}";
  }
}
