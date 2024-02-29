import 'package:chefs_recipes/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.brown,
          ),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              category.color,
              category.color.withOpacity(0.6),
            ],
          ),
        ),
        child: GlowText(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
          glowColor: Colors.black,
        ),
      ),
    );
  }
}
