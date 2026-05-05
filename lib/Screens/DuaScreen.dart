import 'package:flutter/material.dart';

class DuaScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الأدعية",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal.shade900,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: duas.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      duas[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
