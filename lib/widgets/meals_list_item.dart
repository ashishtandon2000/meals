part of "widgets.dart";

class MealsListItem extends StatelessWidget {
  const MealsListItem(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey.withOpacity(.6),
      elevation: 3,
      shadowColor: Colors.white70,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      clipBehavior:Clip.hardEdge ,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            // fit: BoxFit.cover,
            // height: 200,
            // width: double.infinity,
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: MealsItemDetails(meal: meal),
          )
        ],
      ),
    );
  }
}

class MealsItemDetails extends StatelessWidget {
  const MealsItemDetails({required this.meal, super.key});

  final Meal meal;

  String get complexityText {
    final name = meal.complexity.name;
    return name[0].toUpperCase() + name.substring(1); 
  }

  String get affordabilityText {
    final name = meal.affordability.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return  FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: .7,
      child: Container(
        padding: const EdgeInsets.only(
            right: 100,
            left: 10,
            top: 15,
            bottom: 15
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.7),
                Colors.black.withOpacity(.5),
                Colors.black.withOpacity(.3),
                Colors.transparent,
              ],
            )),
        child: Column(
          children: [
            Text(
              meal.title,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                MealItemTrait(
                  icon: Icons.schedule,
                  label: '${meal.duration} min',
                ),
                const SizedBox(width: 12),
                MealItemTrait(
                  icon: Icons.work,
                  label: complexityText,
                ),
                const SizedBox(width: 12),
                MealItemTrait(
                  icon: Icons.attach_money,
                  label: affordabilityText,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}