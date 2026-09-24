import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/meal.dart';

class MealController {
  Future<List<Meal>> getMeals() async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?f=a',
    );

    late http.Response response;

    try {
      response = await http.get(url);
    } on SocketException {
      throw Exception("Sem conexão com a internet");
    }

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar receitas');
    }

    final data = jsonDecode(response.body);
    final meals = data['meals'];

    if (meals == null) {
      return [];
    }

    return (meals as List).map((meal) {
      return Meal(
        id: meal['idMeal'] ?? '',
        name: meal['strMeal'] ?? '',
        imageUrl: meal['strMealThumb'] ?? '',
        category: meal['strCategory'] ?? '',
        area: meal['strArea'] ?? '',
      );
    }).toList();
  }

  Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
    );

    late http.Response response;

    try {
      response = await http.get(url);
    } on SocketException {
      throw Exception("Sem conexão com a internet");
    }

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar receitas');
    }

    final data = jsonDecode(response.body);

    final meals = data['meals'];

    if (meals == null) {
      return [];
    }

    return (meals as List).map((meal) {
      return Meal(
        id: meal['idMeal'] ?? '',
        name: meal['strMeal'] ?? '',
        imageUrl: meal['strMealThumb'] ?? '',
        category: meal['strCategory'] ?? '',
        area: meal['strArea'] ?? '',
      );
    }).toList();
  }
}
