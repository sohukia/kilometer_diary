class KilometerData {
  final int id;
  final double value;
  final DateTime date;

  KilometerData({
    required this.id,
    required this.value,
    required this.date,
  });

  Map<String, Object> toMap() {
    return Map.from({
      'id': id,
      'value': value,
      'date': date,
    });
  }
}
