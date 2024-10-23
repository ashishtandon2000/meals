part of 'providers.dart';

// Never edit value of provider(by using add, remove etc...) instead it is overwritten by assigning whole new value
class FavouriteMealNotifier extends StateNotifier<List<Meal>>{
  FavouriteMealNotifier() : super([]);

  bool toggleFavourite(Meal meal){
    final mealIsFavourite = state.contains(meal);
    if(mealIsFavourite){
      // state = state.where((m)=>m != meal).toList(); // complex approach as here whole meal object will be compared
      state = state.where((m)=>m.id != meal.id).toList(); // instead comparing string(ids) is easier to process

      return false;/// false when meal is removed
    }else{
      state = [...state, meal];
      return true;/// true when meal is added
    }
  }

}

final favouriteMealProvider = StateNotifierProvider<FavouriteMealNotifier, List<Meal>>((ref){
  return FavouriteMealNotifier();
});