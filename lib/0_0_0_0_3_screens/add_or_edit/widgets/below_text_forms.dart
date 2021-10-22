import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/widgets/emoji_widgets.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/widgets/inc_dec_number.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/items/bloc/places_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* THE RATING AND PRICE CHANGING IMPLEMENTATION WITH DELETE OPTION IF EDITING
///*    LOCATED BENEATH TEXT FORMS IN ADD EDIT FORM
///
List<Widget> widgetsBelowTextForms(bool isEditing, IncDecNumber priceValueWidget, IncDecNumber ratingValueWidget, BuildContext context, Place? place) {
 return [const Divider(color: Colors.transparent, height: 30),
                    emojiRow1(),
                    const Divider(color: Colors.transparent, height: 20),
                    Center(child: priceValueWidget),
                    const Divider(color: Colors.transparent, height: 30),
                    emojiRow2(),
                    const Divider(color: Colors.transparent, height: 20),
                    Center(child: ratingValueWidget),
                    const Divider(color: Colors.transparent, height: 30),
                    SizedBox(
                      height: 25,
                      child: (!isEditing)
                          ? const SizedBox()
                          : FittedBox(
                              fit: BoxFit.contain,
                              child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<PlacesBloc>(context)
                                        .add(DeletePlace(place!));
                                    BlocProvider.of<PriceRatingCubit>(context)
                                        .resetPriceRating();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete Place",
                                      style: TextStyle(color: Colors.red))),
                            ),
                    ),
                    Divider(
                        color: Colors.transparent,
                        height: (isEditing) ? 60 : 20),];
}
