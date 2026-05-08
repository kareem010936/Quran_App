import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  DuaScreenState createState() => DuaScreenState();
}

class DuaScreenState extends State<DuaScreen> {
  final List<String> duas = [
    "اللهم إني أسألك العفو والعافية في الدنيا والآخرة.",
    "اللهم أصلح لي ديني الذي هو عصمة أمري.",
    "اللهم لا سهل إلا ما جعلته سهلا، وأنت تجعل الحزن إذا شئت سهلا.",
    "اللهم إني أسألك من الخير كله عاجله وآجله.",
    "اللهم ارزقني علماً نافعاً، ورزقاً طيباً، وعملاً متقبلاً.",
    "اللهم اغفر لي ولوالدي، وللمؤمنين والمؤمنات، الأحياء منهم والأموات.",
    "اللهم اجعل القرآن ربيع قلبي ونور صدري وجلاء حزني.",
    "اللهم إنك عفو تحب العفو فاعفُ عني.",
    "اللهم أعني على ذكرك وشكرك وحسن عبادتك.",
    "اللهم اكفني بحلالك عن حرامك وأغنني بفضلك عمن سواك.",
    "اللهم إني أعوذ بك من زوال نعمتك وتحول عافيتك وفجاءة نقمتك.",
    "اللهم اجعل آخر كلامنا في الدنيا لا إله إلا الله.",
    "اللهم إنك تعلم ما في قلبي فحقق لي ما أتمنى.",
    "اللهم إني أعوذ بك من الهم والحزن والعجز والكسل.",
    "اللهم اجعلنا من عبادك الصالحين الذاكرين الشاكرين.",
  ];

  List<int> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favList = prefs.getStringList("favorites");

    if (favList != null) {
      setState(() {
        favorites = favList.map((e) => int.parse(e)).toList();
      });
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "favorites",
      favorites.map((e) => e.toString()).toList(),
    );
  }

  void toggleFavorite(int index) {
    setState(() {
      if (favorites.contains(index)) {
        favorites.remove(index);
      } else {
        favorites.add(index);
      }
    });
    saveFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0e6058),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "الأدعية",
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              14,
              16,
              14,
              90,
            ),
            itemCount: duas.length,
            itemBuilder: (context, index) {
              final isFav = favorites.contains(index);

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => toggleFavorite(index),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isFav
                                ? Colors.red.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey.shade500,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          duas[index],
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.cairo(
                            color: const Color(0xFF0e6058),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
