import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/meal.dart';

class FavoritesController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> addFavorite(Meal meal) async {
    final database = await _databaseHelper.getDatabase();

    await database.insert('meals', {
      'id': meal.id,
      'name': meal.name,
      'imageUrl': meal.imageUrl,
      'category': meal.category,
      'area': meal.area,
      'custom': meal.custom ? 1 : 0,
      'favorite': 1,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Meal>> getFavorites() async {
    final database = await _databaseHelper.getDatabase();

    final rows = await database.query(
      'meals',
      where: 'favorite = ?',
      whereArgs: [1],
    );

    return rows.map((row) {
      return Meal(
        id: row['id'] as String,
        name: row['name'] as String,
        imageUrl: row['imageUrl'] as String,
        category: row['category'] as String,
        area: row['area'] as String,
        custom: row['custom'] == 1,
        favorite: row['favorite'] == 1,
      );
    }).toList();
  }

  Future<void> removeFavorite(String id) async {
    final database = await _databaseHelper.getDatabase();

    await database.update(
      'meals',
      {
        'favorite': 0
      },
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<bool> isFavorite(String id) async {
  final database = await _databaseHelper.getDatabase();

  final result = await database.query(
    'meals',
    where: 'id = ? AND favorite = ?',
    whereArgs: [id, 1],
  );

  return result.isNotEmpty;
}
}
