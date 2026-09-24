import '../database/database_helper.dart';

import '../model/meal.dart';

class CustomMealController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Meal>> getCustomMeals() async {
    final database = await _databaseHelper.getDatabase();

    final rows = await database.query(
      'meals',
      where: 'custom = ?',
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

  Future<Meal?> getMeal(String id) async {
    final database = await _databaseHelper.getDatabase();

    final rows = await database.query(
      'meals',
      where: 'id = ? AND custom = ?',
      whereArgs: [id, 1],
    );

    if (rows.isEmpty) {
      return null;
    }

    final row = rows.first;

    return Meal(
      id: row['id'] as String,
      name: row['name'] as String,
      imageUrl: row['imageUrl'] as String,
      category: row['category'] as String,
      area: row['area'] as String,
      custom: row['custom'] == 1,
      favorite: row['favorite'] == 1,
    );
  }

  Future<void> addMeal(Meal meal) async {
    final database = await _databaseHelper.getDatabase();

    await database.insert('meals', {
      'id': meal.id,
      'name': meal.name,
      'imageUrl': meal.imageUrl,
      'category': meal.category,
      'area': meal.area,
      'custom': 1,
      'favorite': 0,
    });
  }

  Future<void> updateMeal(Meal meal) async {
    final database = await _databaseHelper.getDatabase();

    await database.update(
      'meals',
      {
        'name': meal.name,
        'imageUrl': meal.imageUrl,
        'category': meal.category,
        'area': meal.area,
      },
      where: 'id = ? AND custom = ?',
      whereArgs: [meal.id, 1],
    );
  }

  Future<void> deleteMeal(String id) async {
    final database = await _databaseHelper.getDatabase();

    await database.delete('meals', where: 'id = ? AND custom = ?', whereArgs: [id, 1]);
  }
}
