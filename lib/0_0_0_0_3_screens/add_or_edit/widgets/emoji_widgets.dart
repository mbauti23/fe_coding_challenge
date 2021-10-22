import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* THE ROW OF DYNAMICALLY COLORED CHARACTERS IN ADDEDITPAGE
///
Widget emojiRow1() {
  const theColor = Color(0xFF198615);
  return BlocBuilder<PriceRatingCubit, PriceRatingState>(
    builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        color: const Color(0xFFEEEEEE),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          direction: Axis.horizontal,
          children: [
            emoji(state.price, 1, "\$", theColor),
            emoji(state.price, 2, "\$", theColor),
            emoji(state.price, 3, "\$", theColor),
          ],
        ),
      );
    },
  );
}

///
///* THE 2ND ROW OF DYNAMICALLY COLORED CHARACTERS IN ADDEDITPAGE
///
Widget emojiRow2() {
  const theColor = Color(0xFFDFAB00);
  return BlocBuilder<PriceRatingCubit, PriceRatingState>(
    builder: (context, state) {
      return Container(
          padding: const EdgeInsets.only(top: 18),
          color: const Color(0xFFEEEEEE),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            direction: Axis.horizontal,
            children: [
              emoji(state.rating, 1, "*", theColor),
              emoji(state.rating, 2, "*", theColor),
              emoji(state.rating, 3, "*", theColor),
              emoji(state.rating, 4, "*", theColor),
              emoji(state.rating, 5, "*", theColor),
            ],
          ));
    },
  );
}

///
///* USES ANIMATED-DEFAULT-TEXT-STYLE AND CONSTRAINTS TO ANIMATE COLOR CHANGES
///
Widget emoji(
    int roundedSliderVal, int constraint, String emoji, Color selectedColor) {
  return AnimatedDefaultTextStyle(
    duration: const Duration(milliseconds: 300),
    child: Text(
      emoji,
      textAlign: TextAlign.center,
    ),
    style: TextStyle(
      color: (roundedSliderVal < constraint) ? Colors.grey : selectedColor,
      fontWeight: FontWeight.bold,
      fontSize: (emoji == "*") ? 60 : 40,
    ),
  );
}
