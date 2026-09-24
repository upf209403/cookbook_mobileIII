import 'package:flutter/material.dart';

import '../model/meal.dart';
import '../view/meal_card.dart';
import '../controller/favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesController _favoritesController = FavoritesController();

  List<Meal> _favorites = [];

  Future<void> _loadFavorites() async {
    final favorites = await _favoritesController.getFavorites();

    setState(() {
      _favorites = favorites;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return MealsCard(meal: _favorites[index]);
        },
      ),
    );
  }
}
