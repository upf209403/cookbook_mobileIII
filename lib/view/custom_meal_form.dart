import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../controller/custom_meal_controller.dart';
import '../model/meal.dart';

class CustomMealForm extends StatefulWidget {
  final Meal? meal;

  const CustomMealForm({super.key, this.meal});

  @override
  State<CustomMealForm> createState() => _CustomMealFormState();
}

class _CustomMealFormState extends State<CustomMealForm> {
  final CustomMealController _customMealController = CustomMealController();
  final Uuid _uuid = const Uuid();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.meal != null) {
      _nameController.text = widget.meal!.name;
      _imageController.text = widget.meal!.imageUrl;
      _categoryController.text = widget.meal!.category;
      _areaController.text = widget.meal!.area;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    _areaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal == null ? 'Nova receita' : 'Editar receita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),

            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'URL da imagem'),
            ),

            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),

            TextField(
              controller: _areaController,
              decoration: const InputDecoration(labelText: 'Origem'),
            ),

            ElevatedButton(
              onPressed: () async {
                final meal = Meal(
                  id: widget.meal?.id ?? _uuid.v4(),
                  name: _nameController.text,
                  imageUrl: _imageController.text,
                  category: _categoryController.text,
                  area: _areaController.text,
                  custom: true,
                );

                if (widget.meal == null) {
                  await _customMealController.addMeal(meal);
                } else {
                  await _customMealController.updateMeal(meal);
                }

                if (!mounted) return;

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
