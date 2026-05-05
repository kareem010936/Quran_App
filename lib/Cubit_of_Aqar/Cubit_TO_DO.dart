import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/SQL/SQL.dart';

class CubitToDo extends Cubit<Appstate> {
  final sql = SQl();

  CubitToDo() : super(InitialState()) {
    _init();
  }

  void _init() async {
    await sql.open();
    get();
  }

  Future<void> get() async {
    emit(LoadingState());
    try {
      var data = await sql.get();
      emit(SuccessStateofTODO(todo: List<Map<String, dynamic>>.from(data)));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await sql.deleteRow(id: id);
      get();
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> addTask(
      String title, String description, String date, String time) async {
    try {
      await sql.insert(
          title: title, description: description, date: date, time: time);
      get();
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
