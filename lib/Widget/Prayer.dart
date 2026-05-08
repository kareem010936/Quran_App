import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Model%20Azqar/Model_Azqar.dart';

class PrayerCard extends StatelessWidget {
  final Map<String, String> prayerTimes;
  final String locationDisplay;
  final bool isLoading;
  final String errorMessage;
  final VoidCallback onRetry;

  const PrayerCard({
    super.key,
    required this.prayerTimes,
    required this.locationDisplay,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: const BoxDecoration(
            color: Color(0xFF0e6058),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(children: [
            const FaIcon(FontAwesomeIcons.mosque,
                color: Colors.amber, size: 32),
            const SizedBox(height: 8),
            Text('مواقيت الصلاة',
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(locationDisplay,
                style: GoogleFonts.cairo(
                    color: Colors.amber,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            if ((prayerTimes['_hijri'] ?? '').isNotEmpty)
              Text(
                "${prayerTimes['_gregorian']} | ${prayerTimes['_hijri']} هـ",
                style: GoogleFonts.cairo(color: Colors.white70, fontSize: 13),
              ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(color: Color(0xFF0e6058)),
                )
              : errorMessage.isNotEmpty
                  ? Column(children: [
                      Text(errorMessage,
                          style: GoogleFonts.cairo(color: Colors.red)),
                      TextButton(
                        onPressed: onRetry,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ])
                  : GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        PrayerItem(
                            name: 'الفجر',
                            time: prayerTimes['الفجر']!,
                            icon: FontAwesomeIcons.cloudSun,
                            color: const Color(0xFF3498DB)),
                        PrayerItem(
                            name: 'الشروق',
                            time: prayerTimes['الشروق']!,
                            icon: FontAwesomeIcons.sun,
                            color: const Color(0xFFF39C12)),
                        PrayerItem(
                            name: 'الظهر',
                            time: prayerTimes['الظهر']!,
                            icon: FontAwesomeIcons.solidSun,
                            color: const Color(0xFFE67E22)),
                        PrayerItem(
                            name: 'العصر',
                            time: prayerTimes['العصر']!,
                            icon: FontAwesomeIcons.cloud,
                            color: const Color(0xFF9B59B6)),
                        PrayerItem(
                            name: 'المغرب',
                            time: prayerTimes['المغرب']!,
                            icon: FontAwesomeIcons.moon,
                            color: const Color(0xFFE74C3C)),
                        PrayerItem(
                            name: 'العشاء',
                            time: prayerTimes['العشاء']!,
                            icon: FontAwesomeIcons.solidMoon,
                            color: const Color(0xFF2C3E50)),
                      ],
                    ),
        ),
        const SizedBox(height: 6),
      ]),
    );
  }
}

class PrayerItem extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final Color color;

  const PrayerItem({
    super.key,
    required this.name,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.12), color.withOpacity(0.05)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25), width: 1.2),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FaIcon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(name,
            style: GoogleFonts.cairo(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(time,
              style: GoogleFonts.cairo(
                  color: color, fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
