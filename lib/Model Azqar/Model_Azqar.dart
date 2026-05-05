class Model_Azqar {
  final String name;
  final int counter;
  
  const Model_Azqar({
    required this.name,
    required this.counter,
  });

  factory Model_Azqar.fromJson(Map<String, dynamic> json, {String? category}) {
    return Model_Azqar(
      name: json['name'],
      counter: json['counter'],
    );
  }
}
