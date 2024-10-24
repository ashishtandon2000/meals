part of "screens.dart";

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  _showSnackBar(
      {required BuildContext context,
      required String message,
      Function()? revert}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: (revert != null)
            ? SnackBarAction(label: "UNDO", onPressed: revert)
            : null,
      ),
    );
  }

  void _toggleAction(context, Meal meal, bool Function(Meal) toggleFavourite) {
    final bool isAdded = toggleFavourite(meal);
    if (isAdded) {
      _showSnackBar(
        context: context,
        message: "${meal.title} added to favourite",
        revert: () {
          _toggleAction(context, meal, toggleFavourite);
        },
      );
    } else {
      _showSnackBar(
        context: context,
        message: "${meal.title} removed from favourite",
        revert: () {
          _toggleAction(context, meal, toggleFavourite);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealProvider);
    final isFavorite = favouriteMeals.contains(meal);
    final toggleFavourite =
        ref.read(favouriteMealProvider.notifier).toggleFavourite;

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                _toggleAction(context, meal, toggleFavourite);
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    // turns: animation,
                    turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  isFavorite
                      ? Icons.star
                      : Icons.star_border,
                  key: ValueKey(isFavorite),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(tag: meal.id, child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
