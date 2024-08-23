import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppDatabase {
  static AppDatabase? _instance;
  late final Database _database;

  AppDatabase._internal(this._database) {
    _createTables(_database);
  }

  static Future<AppDatabase> getDatabase() async {
    if (_instance != null) return _instance!;

    try {
      final path = await _getDatabasePath();
      final database = sqlite3.open(path);
      _instance = AppDatabase._internal(database);
    } catch (e) {
      rethrow;
    }

    return _instance!;
  }

  Database get database => _database;

  static void _createTables(Database db) {
    try {
      db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          full_name TEXT,
          email TEXT UNIQUE,
          password TEXT,
          phone TEXT,
          token TEXT
        )
      ''');

      db.execute('''
       CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            firstGrade REAL,
            secondGrade REAL,
            thirdGrade REAL
        )
      ''');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> _getDatabasePath() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = '${directory.path}/notas.db';
    final file = File(path);

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    return path;
  }
}
























//     db.execute('''








//     ''');


