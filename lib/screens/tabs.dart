part of "screens.dart";


class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int tabIndex = 0;

  _switchTab(int index){
    setState(() {
      tabIndex = index;
    });
  }

  _onSelectDrawerOption(String identifier)async{
    Navigator.of(context).pop();
    if(identifier ==  DrawerOptionsIdentifier.filter.name){
      // final filteredSetting =  await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx)=>const FilterScreen()));
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const FilterScreen()));

    }
  }

  @override
  Widget build(context){
    Widget body;
    String appBarText;
    final favouriteMeals = ref.watch(favouriteMealProvider);
    final filteredMeals = ref.watch(filteredMealsProvider);

    switch(tabIndex){
      case 1: // Favourite Meals
        body = MealsScreen(meals: favouriteMeals);
        appBarText = "Favourite Meals";
        break;

      default:
        body = CategoriesScreen(meals: filteredMeals,);
        appBarText = "Pick your category";

    }

    return Scaffold(
      appBar:AppBar(
        title: Text(appBarText),
      ),
      drawer: AppDrawer(onSelectOption: _onSelectDrawerOption,),
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
                label: "Favorites"
            ),
          ]),
        body: body
    );
  }
}