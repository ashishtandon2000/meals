part of "screens.dart";

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{

  int tabIndex = 0;

  _switchTab(int index){
    setState(() {
      tabIndex = index;
    });

  }

  @override
  Widget build(context){
     Widget body;

    switch(tabIndex){
      case 1: // Favourite Meals
        body = const MealsScreen(title: "Favourite Meals", meals: []);
        break;

      default:
        body = const CategoriesScreen();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: _switchTab,
          currentIndex: tabIndex,
          items: const [
             BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: "Category"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Favorite"
            ),
          ]),
        body: body
    );
  }
}