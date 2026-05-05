class Model_todoloist {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;

  const Model_todoloist(
    this.id, {
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  factory Model_todoloist.fromMap(Map<String, dynamic> json) {
    return Model_todoloist(
      json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
    );
  }
}
