part of 'screens.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilter = ref.watch(filtersProvider);
    final setFilter = ref.read(filtersProvider.notifier).setFilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set filters'),
      ),
      body: Column(
        children: [
          filterTile(context,activeFilter,setFilter,Filter.glutenFree),
          filterTile(context,activeFilter,setFilter,Filter.lactoseFree),
          filterTile(context,activeFilter,setFilter,Filter.vegetarian),
          filterTile(context,activeFilter,setFilter,Filter.vegan),
        ],
      ),
    );
  }

  Widget filterTile(BuildContext context,Map<Filter, bool> activeFilter, void Function(Filter, bool) setFilter,Filter filter){
    String title = "";
    String subTitle = "";

    switch (filter){
      case Filter.glutenFree:
        title = "Gluten-free";
        subTitle = "Only include gluten-free meals.";
      case Filter.lactoseFree:
        title = "Lactose-free";
        subTitle = "Only include lactose-free meals.";
      case Filter.vegetarian:
        title = "Vegetarian";
        subTitle = "Only include vegetarian meals.";
      default:
        title = "Vegan";
        subTitle = "Only include vegan meals.";
    }


    return SwitchListTile(
      value: activeFilter[filter]!,
      onChanged: (isChecked) {
        setFilter(filter, isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}

/*
* pop scope example -
* Scaffold(
      appBar: AppBar(
        title: const Text('Set filters'),
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          // if(didPop){ // better way
          //   return;
          // }
          /// onPopInvokedWithResult can get invoked multiple times, like here - once I press back button onPopInvokedWithResult gets invoked and inside it I have manually popped which causes onPopInvokedWithResult to get invoked again.
          // didPop provides bool value which is true if screen is popped
          // result provides the value that is passed back to the previous screen while popping
          print("Debug running, $didPop $result");

          // if(!didPop){// for better understanding of what is happening here
          //   Navigator.of(context).pop({
          //     Filter.glutenFree: _glutenFreeFilterSet,
          //     Filter.lactoseFree: _lactoseFreeFilterSet,
          //     Filter.vegetarian: _vegetarianFilterSet,
          //     Filter.vegan: _veganFilterSet,
          //   });
          // }
        },
        child: Column(
          children: [
            filterTile(context,activeFilter,setFilter,Filter.glutenFree),
            filterTile(context,activeFilter,setFilter,Filter.lactoseFree),
            filterTile(context,activeFilter,setFilter,Filter.vegetarian),
            filterTile(context,activeFilter,setFilter,Filter.vegan),
          ],
        ),
      ),
    )
*
* */