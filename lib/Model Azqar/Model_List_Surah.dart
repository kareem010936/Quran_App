class ModelListSurah {
  final int number; 
  final String name; 
  final String type; 
  final int count; 

  ModelListSurah({
    required this.number,
    required this.name,
    required this.type,
    required this.count,
  });

  factory ModelListSurah.fromJson(Map<String, dynamic> json) {
    return ModelListSurah(
      number: json['number'],
      name: json['name'] ,
      type: json['revelationType']=='Meccan'?"مكية":"مدنية" ,
      count: json['numberOfAyahs'] ,
    );
  }

}
