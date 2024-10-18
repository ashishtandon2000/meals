part of "screens.dart";

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.title, required this.meals, super.key});

  final String title;
  final List<Meal> meals;

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
            meals[index],
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
