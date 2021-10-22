import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

///
///* FILTER SEARCH BAR WHICH DETERMINES WHICH PLACES WILL BE DISPLAYED VIA NAME
///* DOES NOTHING IF EMPTY OR WHITESPACE
///
class FilterBar extends StatelessWidget {
  const FilterBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteSpaceColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
          onChanged: (String text) {
            final theBloc = context.read<FilteredPlacesBloc>();
            final theState = theBloc.state;
            if (theState is FilteredPlacesLoaded) {
              theBloc.add(UpdateFilter(
                  text, theState.theOrder, theState.selectState));
            }
          },
          style: GoogleFonts.mallanna(
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: mainTextColor.withOpacity(1),
              fontSize: 14),
          decoration: InputDecoration(
              hintText: "Search By Name",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade600))),
    );
  }
}