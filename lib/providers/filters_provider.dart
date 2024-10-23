part of "providers.dart";

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super(kInitialFilters);

  void setFilter(Filter filter, bool set) {
    state = {
      ...state,
      filter: set,
    };
  }

  void setFilters(Map<Filter, bool> filters){
   state = {
     ...state,
     ...filters};
  }
}

final filtersProvider = StateNotifierProvider<FilterNotifier,Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealsProvider = Provider((ref){
  final activeFilters = ref.watch(filtersProvider);
  final meals = ref.read(mealsProvider);
  return meals.where((meal){
    if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(activeFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();
});