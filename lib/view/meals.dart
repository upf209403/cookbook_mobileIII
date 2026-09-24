import 'package:flutter/material.dart';

import '../model/meal.dart';
import '../view/meal_card.dart';

class Meals extends StatelessWidget {
  final List<Meal> meals;

  const Meals({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];

        return MealsCard(meal: meal, showFavorite: true);
      },
    );
  }
}
