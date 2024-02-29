import 'package:chefs_recipes/models/meal.dart';
import 'package:chefs_recipes/screens/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavourite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavourite;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final _favouriteIcon = CupertinoIcons.heart_fill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 24,
            ),
            color: Theme.of(context).primaryColor,
            elevation: 3,
            shadowColor: const Color.fromARGB(255, 255, 255, 255),
            clipBehavior: Clip.hardEdge,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Color.fromARGB(255, 71, 69, 69),
                width: 3,
              ),
            ),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.meal.imageUrl),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: 4),
                height: MediaQuery.of(context).size.height - 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: const Color.fromARGB(46, 255, 255, 255),
                  ),
                  color:
                      Theme.of(context).colorScheme.onTertiary.withOpacity(0.5),
                ),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  children: [
                    Text(
                      "🤔 Description:",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    const SizedBox(height: 12),
                    if (widget.meal.isGlutenFree)
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Gluten Free",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.meal.isLactoseFree)
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Lactose Free",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.meal.isVegetarian)
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Vegetarian",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.meal.isVegan)
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Vegan",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    if (!widget.meal.isVegetarian)
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Non-vegetarian",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    Text(
                      "😋 Ingredients:",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    const SizedBox(height: 12),
                    for (String ingredient in widget.meal.ingredients)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Icon(Icons.circle, size: 12),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                ingredient,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: 24,
                right: 24,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.blueGrey[900],
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RecipeScreen(meal: meal),
                      //   ),
                      // );
                      showModalBottomSheet(
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        context: context,
                        builder: (context) => RecipeScreen(meal: widget.meal),
                      );
                    },
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "👌---Recipe---👌",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 28,
                top: 20,
                child: IconButton(
                  onPressed: () {
                    return widget.onToggleFavourite(widget.meal);
                  },
                  icon: Icon(_favouriteIcon, size: 34),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
