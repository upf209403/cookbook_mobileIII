import 'package:flutter/material.dart';

import '../model/meal.dart';

class MealPage extends StatelessWidget {
  final Meal meal;

  const MealPage({super.key, required this.meal});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            Text(
              meal.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text('Categoria: ${meal.category}'),
            Text('Origem: ${meal.area}'),
          ],
        ),
      ),
    );
  }
}
