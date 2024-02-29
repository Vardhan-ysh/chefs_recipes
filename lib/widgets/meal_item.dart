import 'package:chefs_recipes/models/meal.dart';
import 'package:chefs_recipes/screens/meal_details.dart';
import 'package:chefs_recipes/widgets/meal_item_trait.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  MealItem({required this.meal, super.key, required this.onToggleFavourite});

  final Meal meal;
  late final Color vegetarianImageIconColor;
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 12,
      shadowColor: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailsScreen(
                  meal: meal, onToggleFavourite: onToggleFavourite),
            ),
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 170,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color.fromARGB(190, 0, 0, 0),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 34,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.access_time,
                          label: "${meal.duration} min",
                        ),
                        const SizedBox(width: 24),
                        MealItemTrait(
                          icon: Icons.star,
                          label:
                              "${meal.complexity.name[0].toUpperCase()}${meal.complexity.name.substring(1)}",
                        ),
                        const SizedBox(width: 24),
                        MealItemTrait(
                          icon: Icons.currency_rupee,
                          label:
                              "${meal.affordability.name[0].toUpperCase()}${meal.affordability.name.substring(1)}",
                        ),
                        const Spacer(),
                        ImageIcon(
                          const NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Indian-vegetarian-mark.svg/2048px-Indian-vegetarian-mark.svg.png",
                          ),
                          size: 24,
                          color: (meal.isVegetarian || meal.isVegan)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
