import 'package:flutter/material.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _counter = 0;
  String _selectedZikr = "اختر الذكر";

  final List<String> _azkarList = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
    "أستغفر الله",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "السبحة",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0e6058),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "اختر الذكر الذي تريد التسبيح به:",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.teal, width: 2),
                    ),
                    child: DropdownButton<String>(
                      value:
                          _selectedZikr == "اختر الذكر" ? null : _selectedZikr,
                      hint: Text(
                        "اختر الذكر",
                        style: TextStyle(fontSize: 20, color: Colors.teal),
                      ),
                      isExpanded: true,
                      underline: SizedBox(),
                      items: _azkarList.map((String zikr) {
                        return DropdownMenuItem<String>(
                          value: zikr,
                          child: Text(
                            zikr,
                            style: TextStyle(fontSize: 22),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedZikr = newValue!;
                          _counter = 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    _selectedZikr == "اختر الذكر"
                        ? "لم يتم اختيار ذكر"
                        : _selectedZikr,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$_counter",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedZikr != "اختر الذكر") {
                        setState(() {
                          _counter++;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0e6058),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "سبح",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    child: Text(
                      "إعادة العداد",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
