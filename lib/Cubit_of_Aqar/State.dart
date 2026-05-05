import 'package:quran/Model%20Azqar/Model_Azqar.dart';
import 'package:quran/Model%20Azqar/Model_List_Surah.dart';

abstract class Appstate {}

class InitialState extends Appstate {}

class LoadingState extends Appstate {}

class ErrorState extends Appstate {
  final String error;

  ErrorState({required this.error});
}

class SuccessState extends Appstate {
  final List<Model_Azqar> ls;

  SuccessState({required this.ls});
}

class SuccessStateofTODO extends Appstate {
  final List<Map<String, dynamic>> todo;
  SuccessStateofTODO({required this.todo});
}

class SuccessStateofList extends Appstate {
  final List<ModelListSurah> surahs;
  SuccessStateofList({required this.surahs});
}

class SuccessStateOfListOfSurah extends Appstate {
  final List<Map<String, dynamic>> list; 
  SuccessStateOfListOfSurah({required this.list});
}

