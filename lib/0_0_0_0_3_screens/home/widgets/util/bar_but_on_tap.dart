import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/all_blocs.dart';
import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

///
///* UPDATES LIST'S ORDER BASED ON THE CURRENT FILTEREDPLACESSTATE
///
void updateSort(
    FilteredPlacesLoaded state, BuildContext context, String currentButton) {
  if (currentButton == "price") {
    if (state.theOrder == SortState.defaultSort) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.priceDescending, state.selectState));
    } else if (state.theOrder == SortState.priceDescending) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.priceAscending, state.selectState));
    } else if (state.theOrder == SortState.priceAscending) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.defaultSort, state.selectState));
    } else {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.priceDescending, state.selectState));
    }
  } else {
    if (state.theOrder == SortState.defaultSort) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.ratingDescending, state.selectState));
    } else if (state.theOrder == SortState.ratingDescending) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.ratingAscending, state.selectState));
    } else if (state.theOrder == SortState.ratingAscending) {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.defaultSort, state.selectState));
    } else {
      context.read<FilteredPlacesBloc>().add(UpdateFilter(
          state.activeFilter, SortState.ratingDescending, state.selectState));
    }
  }
}
