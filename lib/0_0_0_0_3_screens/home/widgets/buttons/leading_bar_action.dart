import 'dart:math';

import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/add_or_edit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/items/bloc/places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/selection/cubit/selection_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

///
///*ADD BUTTON AT THE START OF THE APP BAR
///*  THEIR RESPECTIVE TEXT IDENTIFIERS
///
Widget leadingActionButton() {
  return SizedBox(
    child: BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
      builder: (context, state) {
        return InkWell(
            onTap: () async {
              //^IF SELECTING, STOP SELECTING
              if (state is FilteredPlacesLoaded &&
                  state.selectState == SelectState.selecting) {
                context.read<SelectionCubit>().unselectAll();
                context.read<FilteredPlacesBloc>().add(UpdateFilter(
                    state.activeFilter,
                    state.theOrder,
                    SelectState.notSelecting));
              } else {
                //^IF NOT SELECTING, ADD PLACE USING ADDEDIT
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddEditScreen(
                    onSave: (name, imageURL, rating, price) {
                      //! IMAGEURL USES A RANDOM NUMBER UP TO 100
                      final rand = Random();
                      final randImg = rand.nextInt(100);
                      Place placeObj = Place(
                          idParam: const Uuid().v4().toString(),
                          imageUrlParam: (imageURL == "")
                              ? 'https://picsum.photos/seed/$randImg/100/100'
                              : imageURL,
                          nameParam: name,
                          priceParam: price!,
                          ratingParam: rating!);
                      //! ADD PLACE USING ONSAVE PARAMS
                      BlocProvider.of<PlacesBloc>(context)
                          .add(AddPlace(placeObj));
                    },
                    isEditing: false,
                  );
                }));
              }
            },
            //ICON SHOWN DEPENDS ON SELECTION STATE
            child: Icon(
                (state is FilteredPlacesLoaded &&
                        state.selectState == SelectState.selecting)
                    ? Icons.close
                    : Icons.add,
                color: mainTextColor));
      },
    ),
  );
}
