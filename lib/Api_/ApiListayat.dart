import 'package:dio/dio.dart';

class ApiListAyat {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getList() async {
    final response = await dio.get("https://api.alquran.cloud/v1/surah");
    return (response.data['data'] as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
