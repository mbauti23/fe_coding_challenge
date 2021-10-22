import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/widgets/app_bar.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/widgets/below_text_forms.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/widgets/inc_dec_number.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/selection_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///* THESE VALUES ARE RETRIEVED FROM PARENT WHEN ACTION BUTTON IS TAPPED
///
typedef OnSaveCallback = Function(
    String name, String imageURL, int? rating, String? price);

///
///* ADD EDIT SCREEN : SAME LAYOUT ADAPTED FOR BOTH PURPOSES
///
class AddEditScreen extends StatelessWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Place? place;

  const AddEditScreen({
    Key? key,
    required this.onSave,
    required this.isEditing,
    this.place,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    String? _name;
    String? _imageUrl;

    IncDecNumber priceValueWidget = const IncDecNumber(
        upperConstraint: 3, lowerConstraint: 1, type: "price");
    IncDecNumber ratingValueWidget = const IncDecNumber(
        upperConstraint: 5, lowerConstraint: 1, type: "rating");

    return Scaffold(
        //This is to stop the textforms from maintaining/regaining focus when
        //  tapping outside their scope
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(children: [
            getAppBar(context, isEditing),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 136.68571428571428),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0),
                      child: TextFormField(
                        initialValue: isEditing ? place?.getName : '',
                        autofocus: false,
                        style: textTheme.headline5,
                        decoration: const InputDecoration(
                          hintText: 'Name of Place',
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter a name';
                          }
                        },
                        onSaved: (value) => _name = value,
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: isEditing ? place?.getImageUrl : '',
                        maxLines: 1,
                        style: textTheme.headline5,
                        decoration: const InputDecoration(
                          hintText: 'Image URL: Empty for Random',
                        ),
                        onSaved: (value) => _imageUrl = value,
                      ),
                    ),
                    //^RATING AND PRICE WIDGETS BELOW TEXT FIELDS
                    ...widgetsBelowTextForms(isEditing, priceValueWidget,
                        ratingValueWidget, context, place),
                  ],
                ),
              ),
            ),
          ]),
        ),

        ///*BUTTON TO CONFIRM ADD OR EDIT
        floatingActionButton: SelectionButton(
          iconForButton: isEditing ? Icons.check : Icons.add,
          onTap: () {
            final currentState = _formKey.currentState;
            if (currentState != null && currentState.validate()) {
              //! START SAVING VALUES

              final rating =
                  BlocProvider.of<PriceRatingCubit>(context).state.rating;
              final price =
                  BlocProvider.of<PriceRatingCubit>(context).state.price;

              String priceString = "";
              for (int i = 0; i < price; i++) {
                priceString = priceString + "\$";
              }

              currentState.save();
              onSave(_name ?? "Name Of Place", _imageUrl!, rating, priceString);

              Navigator.pop(context);
              BlocProvider.of<PriceRatingCubit>(context).resetPriceRating();

              //! END SAVING VALUES
            }
          },
          buttonHighlight: const Color(0xFF2C562D),
        ));
  }
}
