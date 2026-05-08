import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerApi {
  static const Map<String, Map<String, dynamic>> _cities = {
    'Cairo': {'lat': 30.0444, 'lng': 31.2357, 'ar': 'القاهرة، مصر'},
    'Giza': {'lat': 30.0131, 'lng': 31.2089, 'ar': 'الجيزة، مصر'},
    'Alexandria': {'lat': 31.2001, 'lng': 29.9187, 'ar': 'الإسكندرية، مصر'},
    'Aswan': {'lat': 24.0889, 'lng': 32.8998, 'ar': 'أسوان، مصر'},
    'Luxor': {'lat': 25.6872, 'lng': 32.6396, 'ar': 'الأقصر، مصر'},
    'SharmElSheikh': {'lat': 27.9158, 'lng': 34.3300, 'ar': 'شرم الشيخ، مصر'},
    'Hurghada': {'lat': 27.2579, 'lng': 33.8116, 'ar': 'الغردقة، مصر'},
  };

  static String _to12Hour(String time24) {
    if (time24 == '--') return '--';

    final cleanTime = time24.split(' ').first.trim();
    final parts = cleanTime.split(':');
    if (parts.length < 2) return time24;

    int hour = int.tryParse(parts[0]) ?? 0;
    final minutes = parts[1].padLeft(2, '0');

    final period = hour >= 12 ? 'م' : 'ص';
    hour = hour % 12;
    if (hour == 0) hour = 12;

    return '$hour:$minutes $period';
  }

  static String getArabicName(String cityKey) =>
      _cities[cityKey]?['ar'] ?? 'القاهرة، مصر';

  static Future<Map<String, String>> fetchTimes(String cityKey) async {
    final city = _cities[cityKey] ?? _cities['Cairo']!;

    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings'
      '?latitude=${city['lat']}&longitude=${city['lng']}&method=5',
    );

    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception('فشل الاتصال بالـ API');

    final data = jsonDecode(response.body)['data'];
    final timings = data['timings'];
    final date = data['date'];

    return {
      'الفجر': _to12Hour(timings['Fajr'] ?? '--'),
      'الشروق': _to12Hour(timings['Sunrise'] ?? '--'),
      'الظهر': _to12Hour(timings['Dhuhr'] ?? '--'),
      'العصر': _to12Hour(timings['Asr'] ?? '--'),
      'المغرب': _to12Hour(timings['Maghrib'] ?? '--'),
      'العشاء': _to12Hour(timings['Isha'] ?? '--'),
      '_hijri': date['hijri']['date'] ?? '',
      '_gregorian': date['gregorian']['date'] ?? '',
    };
  }
}
