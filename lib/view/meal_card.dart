import 'package:flutter/material.dart';

import '../model/meal.dart';

import '../controller/favorites_controller.dart';
import '../controller/custom_meal_controller.dart';
import './custom_meal_form.dart';

class MealsCard extends StatefulWidget {
  final Meal meal;
  final bool showFavorite;
  final bool showActions;
  final Future<void> Function()? onChanged;

  const MealsCard({
    super.key,
    required this.meal,
    this.showFavorite = false,
    this.showActions = false,
    this.onChanged,
  });

  @override
  State<MealsCard> createState() => _MealsCardState();
}

class _MealsCardState extends State<MealsCard> {
  bool _isFavorite = false;
  final FavoritesController _favoritesController = FavoritesController();
  final CustomMealController _customMealController = CustomMealController();

  Future<void> _loadFavorite() async {
    final isFavorite = await _favoritesController.isFavorite(widget.meal.id);

    if (!mounted) return;

    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/meal', arguments: widget.meal);
      },
      child: Card(
        child: ListTile(
          leading: SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              widget.meal.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 40);
              },
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showFavorite)
                IconButton(
                  onPressed: () async {
                    if (_isFavorite) {
                      await _favoritesController.removeFavorite(widget.meal.id);
                    } else {
                      await _favoritesController.addFavorite(widget.meal);
                    }

                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
              if (widget.showActions) ...[
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomMealForm(meal: widget.meal),
                      ),
                    );

                    await widget.onChanged?.call();
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Excluir receita'),
                          content: Text(
                            'Deseja excluir a receita "${widget.meal.name}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm != true) return;

                    await _customMealController.deleteMeal(widget.meal.id);

                    await widget.onChanged?.call();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ],
          ),
          title: Text(widget.meal.name),
          subtitle: Text('${widget.meal.category} • ${widget.meal.area}'),
        ),
      ),
    );
  }
}
