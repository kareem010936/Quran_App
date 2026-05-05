import 'package:dio/dio.dart';

class QuranService {
  final Dio _dio = Dio();
  Future<List<Map<String, dynamic>>> fetchAyahs(int surahNumber) async {
    final response = await _dio.get('https://api.alquran.cloud/v1/quran/quran-uthmani');
    final List surahs = response.data['data']['surahs']; 
    final surah = surahs.firstWhere((s) => s['number'] == surahNumber);
    return surah['ayahs'].map<Map<String, dynamic>>((ayah) => {
      "numberInSurah": ayah["numberInSurah"],
      "text": ayah["text"],
    }).toList(); 
  }
}
