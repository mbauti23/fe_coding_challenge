import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


///
///* APP BAR FOR ADD/EDIT PAGE
///
Widget getAppBar(BuildContext context, bool isEditing) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      alignment: Alignment.center,
      color: footerColor,
      child: Transform(
        transform: Matrix4.translationValues(-15, 10, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<PriceRatingCubit>(context).resetPriceRating();
              },
              color: Colors.white,
              icon: const Icon(Icons.arrow_back)),
          const SizedBox(width: 5),
          Text((isEditing ? "Edit" : "Add") + " Place",
              textAlign: TextAlign.center,
              style: GoogleFonts.glegoo(
                  shadows: [
                    const Shadow(
                      color: Colors.black,
                      blurRadius: .5,
                    ),
                  ],
                  letterSpacing: 0,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: 40)),
        ]),
      ),
      //),
      height: 136.68571428571428,
      width: MediaQuery.of(context).size.width,
    ),
  );
}
