import 'package:flutter/material.dart';

import '../controller/custom_meal_controller.dart';
import '../model/meal.dart';

import 'custom_meal_form.dart';
import './meal_card.dart';

class CustomMealPage extends StatefulWidget {
  const CustomMealPage({super.key});

  @override
  State<CustomMealPage> createState() => _CustomMealPageState();
}

class _CustomMealPageState extends State<CustomMealPage> {
  final CustomMealController _customMealController = CustomMealController();

  List<Meal> _meals = [];

  @override
  void initState() {
    super.initState();

    _loadMeals();
  }

  Future<void> _loadMeals() async {
    final meals = await _customMealController.getCustomMeals();

    if (!mounted) return;

    setState(() {
      _meals = meals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas receitas')),
      body: ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];

          return MealsCard(
            key: ValueKey(meal.id),
            meal: meal,
            showActions: true,
            onChanged: _loadMeals,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomMealForm()),
          );

          _loadMeals();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
