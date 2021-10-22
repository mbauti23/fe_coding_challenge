import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/end_button.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///*LIST OF END POSITIONED APPBAR BUTTONS WITH
///*  THEIR RESPECTIVE TEXT IDENTIFIERS
///
List<Widget> appBarActions() {
  const arrowColor = Color(0xFF555555);
  return <Widget>[
    const Center(
        child: Text("Sort By: ", style: TextStyle(color: Colors.black))),
    const SizedBox(width: 3),
    BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
        builder: (context, state) {
      return Row(children: [
        EndBarButton(
            state: state,
            iconList: const [
              Icon(CupertinoIcons.money_dollar, color: mainTextColor, size: 25),
              Icon(Icons.arrow_downward, color: arrowColor, size: 16),
              Icon(Icons.arrow_upward, color: arrowColor, size: 16)
            ],
            padding: const EdgeInsets.all(3),
            currentButton: "price"),
        const SizedBox(width: 8),
        EndBarButton(
            state: state,
            iconList: const [
              Icon(CupertinoIcons.star_lefthalf_fill,
                  color: mainTextColor, size: 18),
              Icon(Icons.arrow_downward, color: arrowColor, size: 16),
              Icon(Icons.arrow_upward, color: arrowColor, size: 16)
            ],
            padding: const EdgeInsets.all(6),
            currentButton: "rating"),
        const SizedBox(width: 8),
      ]);
    }),
  ];
}
