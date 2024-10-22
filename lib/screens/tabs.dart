part of "screens.dart";

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  List<Meal> _favouriteMeals = [];
  var _filterSetting = kInitialFilters;
  int tabIndex = 0;

  _switchTab(int index){
    setState(() {
      tabIndex = index;
    });
  }

  _onSelectDrawerOption(String identifier)async{
    Navigator.of(context).pop();
    if(identifier ==  DrawerOptionsIdentifier.filter.name){
      final filteredSetting =  await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx)=> FilterScreen(
        currentFilterSetting: _filterSetting,
      )));

      if (filteredSetting!=null){
        setState(() {
          _filterSetting = filteredSetting;
        });
      }
    }
  }

  _onToggleFavourite(Meal meal){
    setState(() {
      if(_favouriteMeals.contains(meal)){
        _favouriteMeals.remove(meal);
        _showSnackBar(context,"${meal.title} is removed from favourite.",revert: (){_onToggleFavourite(meal);});
      }else{
        _showSnackBar(context,"${meal.title} is added to favourite.",revert: (){_onToggleFavourite(meal);});
        _favouriteMeals.add(meal);
      }
    });
  }

  _showSnackBar(BuildContext context, String message,{required Function() revert}){
    ScaffoldMessenger.of(context).clearSnackBars();
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),action: SnackBarAction(label: "UNDO", onPressed: revert),));
  }

  @override
  Widget build(context){
    var filteredMeals = dummyMeals;
    Widget body;
    String appBarText;

    filteredMeals = dummyMeals.where((meal){
      // if(filteredSetting[Filter.lactoseFree]??false && !meal.isLactoseFree){
      if(_filterSetting[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_filterSetting[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_filterSetting[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_filterSetting[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    switch(tabIndex){
      case 1: // Favourite Meals
        body = MealsScreen(meals: _favouriteMeals,toggleFavourite: _onToggleFavourite,);
        appBarText = "Favourite Meals";
        break;

      default:
        body = CategoriesScreen(
            meals: filteredMeals,
          toggleFavourite: _onToggleFavourite,
        );
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