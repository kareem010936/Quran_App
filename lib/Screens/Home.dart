import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Widget/Prayer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran/Api_/Api_Prayer.dart';
import 'package:quran/Widget/Azqar.dart';
import 'package:quran/Screens/azqar.dart';
import 'package:quran/Screens/DuaScreen.dart';
import 'package:quran/Screens/ListSurah.dart';
import 'package:quran/Screens/TasbeehScreen.dart';
import 'package:quran/Screens/Todolist.dart';

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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
          onTap: (i) => setState(() => _selectedIndex = i),
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.handsPraying), label: 'الأدعية'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.moon), label: 'الأذكار'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.personPraying), label: 'التسبيح'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bookQuran), label: 'القرآن'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.listCheck), label: 'المهام'),
          ],
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
  String cityKey = 'Cairo';
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
      cityKey = prefs.getString('prayer_city') ?? 'Cairo';
      locationDisplay = PrayerApi.getArabicName(cityKey);
    });
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final times = await PrayerApi.fetchTimes(cityKey);
      if (!mounted) return;
      setState(() {
        prayerTimes = times;
        isLoading = false;
      });
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
              image: AssetImage('assets/img.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(0.15)),
        SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.logout_rounded,
                          color: Colors.white, size: 22),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('login', (r) => false);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(children: [
                  Text(
                    'مرحبًا بك في تطبيق القرآن الكريم',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'جعل الله يومك مليئًا بالبركة',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  PrayerCard(
                    prayerTimes: prayerTimes,
                    locationDisplay: locationDisplay,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onRetry: _fetchPrayerTimes,
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
