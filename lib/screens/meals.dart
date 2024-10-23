part of "screens.dart";

class MealsScreen extends ConsumerWidget {
  const MealsScreen({this.title, required this.meals, super.key});
  final String? title;
  final List<Meal> meals;

  void _onSelectMeal(BuildContext context,Meal meal){
    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(meal)));
    Navigator.of(context).push(MaterialPageRoute(builder:  (ctx)=>MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

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

    if(title==null){// If there is no title, don't show appbar
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
