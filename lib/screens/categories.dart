part of "screens.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  _onSelectCategory(BuildContext context, Category category) {
    var categoryMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: categoryMeals)));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your category"),
      ),
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
