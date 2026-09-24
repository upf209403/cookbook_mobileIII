import 'package:flutter/material.dart';

import '../controller/meal_controller.dart';
import '../model/meal.dart';

import '../view/meals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MealController _mealController = MealController();

  List<Meal> _meals = [];
  String? _errorMessage;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    try {
      final meals = await _mealController.getMeals();

      if (!mounted) return;

      setState(() {
        _meals = meals;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Não foi possível carregar as receitas.';
      });
    }
  }

  Future<void> _searchMeals(String query) async {
    try {
      final meals = await _mealController.searchMeals(query);

      if (!mounted) return;

      setState(() {
        _meals = meals;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Não foi possível carregar as receitas.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CookBook'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/custom-meals');
            },
            icon: const Icon(Icons.restaurant_menu),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Encontre sua próxima receita',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            TextField(
              controller: _searchController,
              onSubmitted: (query) {
                _searchMeals(query);
              },
              decoration: InputDecoration(
                hintText: 'Buscar receita...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Categorias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.wifi_off, size: 60),
                          const SizedBox(height: 16),
                          Text(_errorMessage!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadMeals,
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    )
                  : Meals(meals: _meals),
            ),
          ],
        ),
      ),
    );
  }
}
