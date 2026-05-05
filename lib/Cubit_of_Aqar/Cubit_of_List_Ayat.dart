import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Api_/Api_Ayat.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';

class CubitOfListAyat extends Cubit<Appstate> {
  CubitOfListAyat() : super(InitialState());
  final api = QuranService();

  void fetchAyat(int surahNumber) async {
    try {
      emit(LoadingState()); 
      final List<Map<String, dynamic>> ayahs = await api.fetchAyahs(surahNumber);

      emit(SuccessStateOfListOfSurah(list: ayahs)); 
    } catch (e) {
      emit(ErrorState(error: e.toString())); 
    }
  }
}
