import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_of_List_Suraht.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Widget/Surah.dart';

class Listsurah extends StatefulWidget {
  const Listsurah({super.key});

  @override
  State<Listsurah> createState() => _ListsurahState();
}

class _ListsurahState extends State<Listsurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0e6058),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "القرآن الكريم",
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          BlocBuilder<CubitOfListSuraht, Appstate>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return Center(
                  child: Text(
                    "حدث خطأ: ${state.error}",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              } else if (state is SuccessStateofList) {
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
                  itemCount: state.surahs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Surah(x: state.surahs[index]),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
