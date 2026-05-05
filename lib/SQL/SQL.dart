import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQl {
  Database? db;

  Future<void> open() async {
    final path = join(await getDatabasesPath(), 'quran.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE todo (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            time TEXT
          )
        ''');
      },
    );

    print(" DB OPENED");
  }

  Future<void> insert({
    required String title,
    required String description,
    required String date,
    required String time,
  }) async {
    await db!.insert("todo", {
      "title": title,
      "description": description,
      "date": date,
      "time": time
    });

    print(" INSERT DONE");
  }

  Future<List<Map<String, dynamic>>> get() async {
    final data = await db!.query("todo");
    print(" DATA: $data");
    return data;
  }

  Future<void> deleteRow({required int id}) async {
    await db!.delete("todo", where: "id = ?", whereArgs: [id]);
  }

  Future<int?> countRows() async {
    return Sqflite.firstIntValue(
        await db!.rawQuery("SELECT COUNT(*) FROM todo"));
  }
}
