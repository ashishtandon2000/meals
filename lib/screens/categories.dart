part of "screens.dart";

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({required this.meals, super.key});

  final List<Meal> meals;

  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  /// Animation Step- 1. Declare the animation controller...
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    /// Animation Step- 2. Initialize the animation controller..
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    /// Animation Step- 4. Start animation using controller
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  _onSelectCategory(BuildContext context, Category category) {
    var categoryMeals = widget.meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: categoryMeals)));
  }

  @override
  Widget build(context) {
    return Scaffold(
      /// Animation Step- 3. Create animation widget
        body: AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (ctx, child) => SlideTransition(
        // position: _animationController.drive(
        //   Tween(
        //     begin: const Offset(0, .3),
        //         end: const Offset(0, 0)
        //   )
        // ),
        position: Tween(
            begin: const Offset(0, .3),
            end: const Offset(0, 0)
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut)),
        child: child,
      ),
    ));
  }
}
