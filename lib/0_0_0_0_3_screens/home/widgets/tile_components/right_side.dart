import 'dart:math';
import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/add_or_edit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/all_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* RIGHT SIDE OF PLACE TILE, INCLUDES NAME, PRICE, RATING, AND
///*      EDIT IF NOT SELECTING
///
Widget rightSideWidget(
    SelectState multiSelecting, Place place, BuildContext context) {
  return Expanded(
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    const SizedBox(width: 10),
    //^ ALL TEXT RELATING TO RIGHT SIDE
    Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(place.getName, style: const TextStyle(fontSize: 18)),
      const SizedBox(height: 15),
      Row(children: [
        Text("Price: ${place.getPrice}", style: const TextStyle(fontSize: 15)),
        const SizedBox(width: 10),
        Text("Rating: " + place.getRating.toString(),
            style: const TextStyle(fontSize: 15)),
      ])
    ])),
    (multiSelecting == SelectState.notSelecting)
        ?
        //^ EDIT ICON WITH EDIT FUNCTIONALITY
        InkWell(
            onTap: () {
              BlocProvider.of<PriceRatingCubit>(context).editPriceRatingWith(
                  ratingParam: place.rating, priceParam: place.getPrice.length);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context2) {
                  return AddEditScreen(
                    onSave: (name, imageURL, rating, price) {
                      final rand = Random();
                      final randImg = rand.nextInt(100);
                      context.read<PlacesBloc>().add(
                            UpdatePlace(place.copyWith(
                                nameCopyParam: name,
                                imageUrlCopyParam: (imageURL == "")
                                    ? 'https://picsum.photos/seed/$randImg/100/100'
                                    : imageURL,
                                priceCopyParam: price,
                                ratingCopyParam: rating)),
                          );
                    },
                    isEditing: true,
                    place: place,
                  );
                },
              ));
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.edit)))
        : const SizedBox(),
    const SizedBox(width: 10),
  ]));
}
