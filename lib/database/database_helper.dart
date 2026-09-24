import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = join(databasesPath, 'cookbook.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE meals (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            category TEXT NOT NULL,
            area TEXT NOT NULL,
            custom INTEGER NOT NULL,
            favorite INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}
