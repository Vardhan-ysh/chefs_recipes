import 'package:chefs_recipes/data/dummy_data.dart';
import 'package:chefs_recipes/models/category.dart';
import 'package:chefs_recipes/models/meal.dart';
import 'package:chefs_recipes/screens/meals.dart';
import 'package:chefs_recipes/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavourite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
    //Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Category"),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 11 / 7,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map((category) {
            return CategoryGridItem(
              onSelectCategory: () {
                _selectCategory(context, category);
              },
              category: category,
            );
          }),
        ],
      ),
    );
  }
}
