import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quran/screens/Azqar.dart';
import 'package:quran/screens/DuaScreen.dart';
import 'package:quran/screens/Listsurah.dart';
import 'package:quran/screens/TasbeehScreen.dart';
import 'package:quran/screens/Todolist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();

      case 1:
        return DuaScreen();

      case 2:
        return Azqar();

      case 3:
        return TasbeehScreen();

      case 4:
        return Listsurah();

      case 5:
        return Todolist();

      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getScreen(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.98),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF0e6058),
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
            iconSize: 26,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.handsPraying),
                label: "الأدعية",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.moon),
                label: "الأذكار",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.personPraying),
                label: "التسبيح",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bookQuran),
                label: "القرآن",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.listCheck),
                label: "المهام",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> prayerTimes = {};

  bool isLoading = true;

  String errorMessage = '';

  String city = 'Cairo';

  String country = 'Egypt';

  String locationDisplay = 'القاهرة، مصر';

  @override
  void initState() {
    super.initState();

    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      city = prefs.getString('prayer_city') ?? 'Cairo';

      country = prefs.getString('prayer_country') ?? 'Egypt';

      locationDisplay = _getArabicName(city);
    });

    fetchPrayerTimes();
  }

  String _getArabicName(String cityEn) {
    final map = {
      'Cairo': 'القاهرة، مصر',
      'Giza': 'الجيزة، مصر',
      'Alexandria': 'الإسكندرية، مصر',
      'Aswan': 'أسوان، مصر',
      'Luxor': 'الأقصر، مصر',
      'Sharm El-Sheikh': 'شرم الشيخ، مصر',
      'Hurghada': 'الغردقة، مصر',
    };

    return map[cityEn] ?? 'القاهرة، مصر';
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final url = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=5',
      );

      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final timings = data['data']['timings'];

        final date = data['data']['date'];

        setState(() {
          prayerTimes = {
            'الفجر': timings['Fajr'] ?? '--',
            'الشروق': timings['Sunrise'] ?? '--',
            'الظهر': timings['Dhuhr'] ?? '--',
            'العصر': timings['Asr'] ?? '--',
            'المغرب': timings['Maghrib'] ?? '--',
            'العشاء': timings['Isha'] ?? '--',
            '_hijri': date['hijri']['date'] ?? '',
            '_gregorian': date['gregorian']['date'] ?? '',
          };

          isLoading = false;
        });
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'تعذر تحميل المواقيت';

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.15),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();

                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              'login',
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ),
                    Text(
                      "الصفحة الرئيسية",
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "مرحبًا بك في تطبيق القرآن الكريم",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "أهلاً بيك، جعل الله يومك مليئًا بالبركة",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.96),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0e6058),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(28),
                                  topRight: Radius.circular(28),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.mosque,
                                    color: Colors.amber,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "مواقيت الصلاة",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    locationDisplay,
                                    style: GoogleFonts.cairo(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (prayerTimes['_hijri'] != null)
                                    Text(
                                      "${prayerTimes['_gregorian']} | ${prayerTimes['_hijri']} هـ",
                                      style: GoogleFonts.cairo(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: isLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(24),
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF0e6058),
                                      ),
                                    )
                                  : errorMessage.isNotEmpty
                                      ? Text(
                                          errorMessage,
                                          style: GoogleFonts.cairo(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        )
                                      : GridView.count(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisCount: 3,
                                          childAspectRatio: 1.0,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          children: [
                                            _buildPrayerItem(
                                              name: 'الفجر',
                                              time: prayerTimes['الفجر']!,
                                              icon: FontAwesomeIcons.cloudSun,
                                              color: const Color(0xFF3498DB),
                                            ),
                                            _buildPrayerItem(
                                              name: 'الشروق',
                                              time: prayerTimes['الشروق']!,
                                              icon: FontAwesomeIcons.sun,
                                              color: const Color(0xFFF39C12),
                                            ),
                                            _buildPrayerItem(
                                              name: 'الظهر',
                                              time: prayerTimes['الظهر']!,
                                              icon: FontAwesomeIcons.solidSun,
                                              color: const Color(0xFFE67E22),
                                            ),
                                            _buildPrayerItem(
                                              name: 'العصر',
                                              time: prayerTimes['العصر']!,
                                              icon: FontAwesomeIcons.cloud,
                                              color: const Color(0xFF9B59B6),
                                            ),
                                            _buildPrayerItem(
                                              name: 'المغرب',
                                              time: prayerTimes['المغرب']!,
                                              icon: FontAwesomeIcons.moon,
                                              color: const Color(0xFFE74C3C),
                                            ),
                                            _buildPrayerItem(
                                              name: 'العشاء',
                                              time: prayerTimes['العشاء']!,
                                              icon: FontAwesomeIcons.solidMoon,
                                              color: const Color(0xFF2C3E50),
                                            ),
                                          ],
                                        ),
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerItem({
    required String name,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.12),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.cairo(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              style: GoogleFonts.cairo(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
