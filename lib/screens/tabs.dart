import 'package:chefs_recipes/models/meal.dart';
import 'package:chefs_recipes/providers/meals_provider.dart';
import 'package:chefs_recipes/screens/categories.dart';
import 'package:chefs_recipes/screens/filters.dart';
import 'package:chefs_recipes/screens/meals.dart';
import 'package:chefs_recipes/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  void _showInfoMessage({required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: const Color.fromARGB(255, 16, 22, 3),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    var favouriteMealsCheck = _favouriteMeals.contains(meal);
    if (favouriteMealsCheck) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage(message: "Meal removed from favourites...");
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage(message: "Meal added to favourites...");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == "filters") {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      // print(result);
      setState(() {
        _selectedFilters = result ??
            {
              Filter.glutenFree: false,
              Filter.lactoseFree: false,
              Filter.vegan: false,
              Filter.vegetarian: false,
            };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where(
      (meal) {
        if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    // String _activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        title: "Your Favourites",
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      // _activePageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 32, 21, 21),
        iconTheme: const IconThemeData(size: 36),
        elevation: 6,
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 26,
            ),
        title: const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            "Chef's Recipes",
          ),
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: activePage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            label: "Categories",
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stars,
            ),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
