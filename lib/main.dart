import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quran/Screens/AuthGate.dart';
import 'firebase_options.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_TO_DO.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_of_List_Ayat.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_of_List_Suraht.dart';
import 'package:quran/Screens/Home.dart';
import 'package:quran/Screens/LoginScreen.dart';
import 'package:quran/Screens/SignUpScreen.dart';
import 'package:quran/Screens/LocationScreen.dart';
import 'package:quran/Screens/ListSurah.dart';
import 'package:quran/Screens/Surah_ayat.dart';
import 'package:quran/Screens/azqar.dart';
import 'package:quran/Screens/Todolist.dart';
import 'package:quran/Screens/TasbeehScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitToDo()..get()),
        BlocProvider(create: (context) => CubitOfListSuraht()..get()),
        BlocProvider(create: (context) => CubitOfListAyat()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "login": (context) => LoginScreen(),
          "signup": (context) => SignUpScreen(),
          "location": (context) => LocationScreen(),
          "home": (context) => Home(),
          "azqar": (context) => Azqar(),
          "Todo": (context) => Todolist(),
          "quran": (context) => Listsurah(),
          "SurahAyat": (context) => SurahAyatScreen(),
          "tasbeeh": (context) => TasbeehScreen(),
        },
        home: AuthGate(),
      ),
    );
  }
}
