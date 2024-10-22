part of "screens.dart";

class MealsScreen extends StatelessWidget {
  const MealsScreen({this.title, required this.meals,required this.toggleFavourite, super.key});

  final Function(Meal meal) toggleFavourite;
  final String? title;
  final List<Meal> meals;

  void _onSelectMeal(BuildContext context,Meal meal){
    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(meal)));
    Navigator.of(context).push(MaterialPageRoute(builder:  (ctx)=>MealDetailsScreen(meal: meal,toggleFavourite: toggleFavourite,)));
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
