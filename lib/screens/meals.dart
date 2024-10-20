part of "screens.dart";

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.title, required this.meals, super.key});

  final String title;
  final List<Meal> meals;

  void _onSelectMeal(BuildContext context,Meal meal){
    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(meal)));
    Navigator.of(context).push(MaterialPageRoute(builder:  (ctx)=>MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const EmptyScreenMsg("No meals found");

    if (meals.isNotEmpty) {
      content = SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: meals.length,
          itemBuilder: (context, index) => MealsListItem(
            meal: meals[index],
            onSelectMeal: (meals){
              _onSelectMeal(context,meals);
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
