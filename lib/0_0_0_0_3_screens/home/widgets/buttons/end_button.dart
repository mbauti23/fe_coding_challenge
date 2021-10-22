
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/util/bar_but_on_tap.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';

///
///*END POSITIONED APPBAR BUTTON
///* FILTEREDPLACESSTATE STATE : WHICH FILTER ARE WE USING HERE
///* EDGEINSETSGEOMETRY PADDING : WHICH PADDING BECAUSE ICONS ARE WEIRD
///* List<ICON> ICONLIST : CURRENT LIST FOR RETRIEVAL (DOWN, UP, DEFAULT)
///* STRING CURRENTBUTTON : IS THIS PRICE OR RATING?
///
class EndBarButton extends StatelessWidget {
  const EndBarButton(
      {Key? key,
      required this.state,
      required this.iconList,
      required this.padding,
      required this.currentButton})
      : super(key: key);

  final FilteredPlacesState state;
  final EdgeInsetsGeometry padding;
  final List<Icon> iconList;
  final String currentButton;

  @override
  Widget build(BuildContext context) {
    return buttonWrapper(context, state, iconList, padding, currentButton);
  }

  Widget buttonWrapper(BuildContext context, FilteredPlacesState state,
      List<Icon> iconList, EdgeInsetsGeometry padding, String? currentButton) {
    return InkWell(
        onTap: () => (state is FilteredPlacesLoaded)
            ? updateSort(state, context, currentButton!)
            : null,
        child: Container(
            height: 36,
            width: 36,
            alignment: Alignment.center,
            padding: padding,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: whiteSpaceColor),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                    offset: (currentButton == "price")
                        ? Offset(
                            (state is FilteredPlacesLoaded &&
                                    (state.theOrder == SortState.defaultSort ||
                                        state.theOrder ==
                                            SortState.ratingAscending ||
                                        state.theOrder ==
                                            SortState.ratingDescending))
                                ? 0
                                : -5,
                            0)
                        : Offset(
                            (state is FilteredPlacesLoaded &&
                                    (state.theOrder == SortState.defaultSort ||
                                        state.theOrder ==
                                            SortState.priceAscending ||
                                        state.theOrder ==
                                            SortState.priceDescending))
                                ? 0
                                : -5,
                            0),
                    child: iconList[0]),
                Align(
                    //Stacked Icon representing the current sort, blank being default
                    alignment: Alignment.centerRight,
                    child: (state is FilteredPlacesLoaded)
                        ? Transform.translate(
                            offset: (currentButton == "price")
                                ? const Offset(0, 0)
                                : const Offset(5, 0),
                            child:
                                retrieveIcon(iconList, state, currentButton!))
                        : const SizedBox())
              ],
            )));
  }

  Widget retrieveIcon(
      List<Icon> iconList, FilteredPlacesLoaded state, String currentButton) {
    if (currentButton == "price") {
      if (state.theOrder == SortState.defaultSort) {
        return const SizedBox();
      } else if (state.theOrder == SortState.priceAscending) {
        return iconList[2];
      } else if (state.theOrder == SortState.priceDescending) {
        return iconList[1];
      } else {
        return const SizedBox();
      }
    } else {
      if (state.theOrder == SortState.defaultSort) {
        return const SizedBox();
      } else if (state.theOrder == SortState.ratingAscending) {
        return iconList[2];
      } else if (state.theOrder == SortState.ratingDescending) {
        return iconList[1];
      } else {
        return const SizedBox();
      }
    }
  }
}
