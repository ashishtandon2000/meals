part of 'widgets.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({required this.onSelectCategory, required this.category, super.key});

  final void Function() onSelectCategory;
  final Category category;

  @override
  Widget build(BuildContext context) {
    // Border radius needs to be provided to both container as well as inkwell
    const  itemBorderRadius =  BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10));

    return InkWell(
      onTap: onSelectCategory,
      splashColor: Colors.white.withOpacity(.5),
      // splashColor: Theme.of(context).primaryColor,
      borderRadius: itemBorderRadius,
      child: Container(
        padding: const EdgeInsets.all(8),
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color,
              category.color.withOpacity(.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: itemBorderRadius,
        ),
        child: Text(category.title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),),
      ),
    );
  }
}
