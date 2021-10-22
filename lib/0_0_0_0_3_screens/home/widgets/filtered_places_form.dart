import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/selection/cubit/selection_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/util/places_to_selection.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_item.dart';

///
///* FILTERED PLACES : Implements main Builder for Filtered Places Bloc
///* updates Place Items based on THEORDER, ACTIVEFILTER, SELECTSTATE
///
class FilteredPlaces extends StatelessWidget {
  const FilteredPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          backgroundGradient(),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
                  builder: (context, state) {
                if (state is FilteredPlacesLoading) {
                  return const Center(
                      child: CircularProgressIndicator(color: highlightColor));
                } else if (state is FilteredPlacesLoaded) {
                  //! START OF UPDATES

                  final loadedFiltersState = state;

                  ///* INITIALIZES THE MAP WITH PLACES AND FALSE VALUED BOOLS
                  if (context.read<SelectionCubit>().state
                      is InitialSelectionState) {
                    context.read<SelectionCubit>().initializeState(
                        placesToSelection(loadedFiltersState.filteredPlaces));
                  }

                  ///* UPDATES SELECTION MAP WITH ANY PLACE LIST CHANGES
                  ///*    IF ALREADY INITIALIZED
                  ///* IF FILTERED VIA SEARCH, WILL UNSELECT
                  ///*    ANY FILTERED ITEMS
                  if (context.read<SelectionCubit>().state
                      is LoadedSelectionState) {
                    var currentMap = (context.read<SelectionCubit>().state
                            as LoadedSelectionState)
                        .getIdToSelected;
                    var newMap =
                        placesToSelection(loadedFiltersState.filteredPlaces);
                    newMap.updateAll(
                        (key, value) => value = currentMap[key] ?? false);
                    context.read<SelectionCubit>().updateMap(newMap);

                    //! END OF UPDATES

                  }
                  //^LISTVIEW FOR PLACES
                  final places = loadedFiltersState.filteredPlaces;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final Place place = places[index];
                      return PlaceItem(
                        //place that will represent the item
                        place: place,
                        //long press has been activated or not
                        multiSelecting: loadedFiltersState.selectState,
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              })),
        ]),
      ),
    );
  }

  Widget backgroundGradient() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFDDDDDD), Color(0xFFBBBBBB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)));
  }
}
