part of "widgets.dart";

enum  DrawerOptionsIdentifier  {
  filter,
  meal
}

class AppDrawer extends StatelessWidget{
  const AppDrawer({required this.onSelectOption,super.key});

  final void Function(String identifier) onSelectOption;


  @override
  Widget build(context){
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryContainer.withOpacity(.8)
                  ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)
            ),
            child: Row(
            children: [
              Icon(
                Icons.fastfood,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 18),
              Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),),
          _drawerOptionTile(context: context,icon: Icons.settings, title: "Filter",onTap: (){onSelectOption(DrawerOptionsIdentifier.filter.name);}),
          _drawerOptionTile(context: context,icon: Icons.settings, title: "Meals",onTap: (){onSelectOption(DrawerOptionsIdentifier.meal.name);})
        ],
      ),

    );
  }

  ListTile _drawerOptionTile(
      {required BuildContext context,required IconData icon,required String title, required void Function() onTap}) {
    return ListTile(

          leading: Icon(
            icon,
            size: 26,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
            ),
          ),
          onTap: onTap,
        );
  }
}