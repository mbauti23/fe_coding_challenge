import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/selection/cubit/selection_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/tile_components/left_side.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/tile_components/right_side.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* THE LIST TILE REPRESENTING THE CURRENT PLACE
///
class PlaceItem extends StatelessWidget {
  final SelectState multiSelecting;
  final Place place;

  const PlaceItem({
    Key? key,
    required this.multiSelecting,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<SelectionCubit, SelectionState>(
          builder: (context, state) {
        final filteredState = (BlocProvider.of<FilteredPlacesBloc>(context)
            .state as FilteredPlacesLoaded);
        final selectionCubit = BlocProvider.of<SelectionCubit>(context);

        if (state is LoadedSelectionState) {
          final LoadedSelectionState loadedSelectionState = state;
          final bool idToSelected =
              loadedSelectionState.getIdToSelected[place.id] ?? false;

          return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              onLongPress: () =>
                  onLongPress(filteredState, context, selectionCubit),
              onTap: (multiSelecting == SelectState.selecting)
                  ? () {
                      (idToSelected == false)
                          ? selectionCubit.selectFrom(place.id)
                          : selectionCubit.unselectFrom(place.id);
                    }
                  : null,
              //! PLACE TILE VISUAL ELEMENTS    
              title: Container(
                  width: (MediaQuery.of(context).size.width),
                  padding:
                      const EdgeInsets.only(top: 15, bottom: 15, right: 10),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: (idToSelected == false)
                          ? whiteSpaceColor //UNSELECTED
                          : const Color(0xFFFAF7C0), //SELECTED
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    //^LEFT SIDE OF TILE
                    leftSideWidget(multiSelecting, place, context,
                        selectionCubit, idToSelected),
                    //^RIGHT SIDE OF TILE    
                    rightSideWidget(multiSelecting, place, context)
                  ])));
        }
        return const SizedBox();
      }),
    );
  }

  ///*START SELECTING 
  void onLongPress(FilteredPlacesLoaded filteredState, BuildContext context,
      SelectionCubit selectionCubit) {
    if (filteredState.selectState == SelectState.notSelecting) {
      BlocProvider.of<FilteredPlacesBloc>(context).add(UpdateFilter(
          filteredState.activeFilter,
          filteredState.theOrder,
          SelectState.selecting));

      selectionCubit.selectFrom(place.id);
    }
  }
}
