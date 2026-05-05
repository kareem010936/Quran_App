import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_of_List_Ayat.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Model%20Azqar/Model_Ayat.dart';
import 'package:quran/Widget/Surah_Ayat.dart';

class SurahAyatScreen extends StatelessWidget {
  const SurahAyatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! int) {
      return const Scaffold(
        body: Center(
          child: Text("حدث خطأ في تحميل السورة"),
        ),
      );
    }

    final int surahNumber = args;

    return BlocProvider(
      create: (context) => CubitOfListAyat()..fetchAyat(surahNumber),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0e6058),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "آيات السورة",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.08,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            BlocBuilder<CubitOfListAyat, Appstate>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ErrorState) {
                  return Center(
                    child: Text(
                      "حدث خطأ: ${state.error}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else if (state is SuccessStateOfListOfSurah) {
                  final List<AyahModel> ayahList = state.list
                      .map(
                        (ayah) => AyahModel(
                          numberInSurah: ayah['numberInSurah'],
                          text: ayah['text'],
                        ),
                      )
                      .toList();

                  return SurahAyatWidget(
                    ayahs: ayahList,
                    surahNumber: surahNumber,
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
