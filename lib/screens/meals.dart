import 'package:chefs_recipes/models/meal.dart';
import 'package:chefs_recipes/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    required this.meals,
    required this.title,
    super.key,
    required this.onToggleFavourite,
  });

  final List<Meal> meals;
  final String title;
  final void Function(Meal meal) onToggleFavourite;

  Widget _content(BuildContext context) {
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 68),
            Text(
              "It's Empty In Here...🤔",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Try saving some meals. They will show up here!",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100),
            const Icon(
              Icons.no_meals,
              size: 100,
            ),
            const SizedBox(height: 300),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) =>
            MealItem(meal: meals[index], onToggleFavourite: onToggleFavourite),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: Text(title),
      ),
      body: _content(context),
    );
  }
}
