import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///*
///* INCDECNUMBER : PRODUCES A NUMBER CHANGE WIDGET FOR ONE OF TWO TYPES
///* USES TEXTFIELD VALUE RATHER THAN READING FROM CUBIT FOR ONSAVED   
///*
class IncDecNumber extends StatelessWidget {
  const IncDecNumber(
      {Key? key,
      required this.upperConstraint,
      required this.lowerConstraint,
      required this.type})
      : super(key: key);

  final int upperConstraint;
  final int lowerConstraint;
  final String type;

  @override
  Widget build(BuildContext context) {
    PriceRatingCubit prCubit = BlocProvider.of<PriceRatingCubit>(context);
    PriceRatingState prState = prCubit.state;
    var textValue = (type == "price") ? prState.price : prState.rating;
    final TextEditingController teController =
        TextEditingController(text: textValue.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (textValue > lowerConstraint) {
                (type == "price")
                    ? prCubit.decrementPrice()
                    : prCubit.decrementRating();
                --textValue;
                teController.text = textValue.toString();
              }
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                color: footerColor,
                child: const Icon(Icons.remove, color: Colors.white))),
        SizedBox(
          width: 50,
          child: TextField(
            textAlign: TextAlign.center,
            enabled: false,
            controller: teController,
          ),
        ),
        InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (textValue < upperConstraint) {
                (type == "price")
                    ? prCubit.incrementPrice()
                    : prCubit.incrementRating();
                ++textValue;
                teController.text = textValue.toString();
              }
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                color: footerColor,
                child: const Icon(Icons.add, color: Colors.white))),
      ],
    );
  }
}
