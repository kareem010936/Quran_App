import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? selectedLocationName;

  final List<Map<String, dynamic>> locations = [
    {
      "name": "القاهرة، مصر",
      "icon": FontAwesomeIcons.city,
      "city": "Cairo",
      "country": "Egypt"
    },
    {
      "name": "الجيزة، مصر",
      "icon": FontAwesomeIcons.building,
      "city": "Giza",
      "country": "Egypt"
    },
    {
      "name": "الإسكندرية، مصر",
      "icon": FontAwesomeIcons.water,
      "city": "Alexandria",
      "country": "Egypt"
    },
    {
      "name": "أسوان، مصر",
      "icon": FontAwesomeIcons.treeCity,
      "city": "Aswan",
      "country": "Egypt"
    },
    {
      "name": "الأقصر، مصر",
      "icon": FontAwesomeIcons.monument,
      "city": "Luxor",
      "country": "Egypt"
    },
    {
      "name": "شرم الشيخ، مصر",
      "icon": FontAwesomeIcons.umbrellaBeach,
      "city": "SharmElSheikh",
      "country": "Egypt"
    },
    {
      "name": "الغردقة، مصر",
      "icon": FontAwesomeIcons.fish,
      "city": "Hurghada",
      "country": "Egypt"
    },
  ];

  Map<String, dynamic>? selectedLocationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "اختر موقعك",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0e6058),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img_2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: MediaQuery.of(context).viewInsets.bottom + 40,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.amber,
                      size: 40,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "اختر موقعك الحالي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "لعرض مواقيت الصلاة الصحيحة",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.amber.shade700,
                          width: 2,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedLocationName,
                          hint: const Text(
                            "اختر المدينة",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF0e6058),
                          ),
                          items: locations.map((location) {
                            return DropdownMenuItem<String>(
                              value: location["name"],
                              child: Row(
                                children: [
                                  FaIcon(
                                    location["icon"],
                                    color: const Color(0xFF0e6058),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    location["name"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocationName = newValue;
                              selectedLocationData = locations.firstWhere(
                                (loc) => loc["name"] == newValue,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedLocationData == null
                            ? null
                            : () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                await prefs.setString(
                                  'prayer_city',
                                  selectedLocationData!["city"],
                                );
                                await prefs.setString(
                                  'prayer_country',
                                  selectedLocationData!["country"],
                                );

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "تم اختيار: $selectedLocationName",
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: const Color(0xFF0e6058),
                                    ),
                                  );

                                  Future.delayed(
                                    const Duration(milliseconds: 800),
                                    () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0e6058),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          disabledBackgroundColor: Colors.grey.shade700,
                        ),
                        child: const Text(
                          "تأكيد الموقع",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
