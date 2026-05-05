import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Api_/ApiListayat.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Model%20Azqar/Model_List_Surah.dart';

class CubitOfListSuraht extends Cubit<Appstate> {
  CubitOfListSuraht() : super(InitialState());

  final api = ApiListAyat();

  Future<void> get() async {
    emit(LoadingState()); 

    try {
      List<Map<String, dynamic>> data = await api.getList(); 
      List<ModelListSurah> lst = data.map((e) => ModelListSurah.fromJson(e)).toList();
      emit(SuccessStateofList(surahs: lst)); 
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
