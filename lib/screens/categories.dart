part of "screens.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.meals,required this.toggleFavourite, super.key});

  final Function(Meal meal) toggleFavourite;
  final List<Meal> meals;

  _onSelectCategory(BuildContext context, Category category) {
    var categoryMeals = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: categoryMeals,toggleFavourite: toggleFavourite,)));
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2, // Expect ratio of child - Width / Height
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          /// Method 1...Using spread operator and .map function
          // ...availableCategories.map((category)=>CategoryGridItem(category: category))

          /// Method 2....using for loop
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _onSelectCategory(context, category);
              },
            )
        ],

        /// Method 3... Using .map and .toList to provide whole list directly to children...
        // availableCategories.map((category)=>CategoryGridItem(category: category)).toList()
      ),
    );
  }
}
