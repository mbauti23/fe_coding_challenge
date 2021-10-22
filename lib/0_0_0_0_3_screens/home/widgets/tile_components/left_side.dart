import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/all_blocs.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';

///
///* LEFT SIDE OF THE PLACE TILE, INCLUDES CHECKMARK (IF SELECTING) AND IMAGE
///
Widget leftSideWidget(SelectState multiSelecting, Place place, BuildContext context, SelectionCubit selectionCubit, bool idToSelected) {
  return SizedBox(
      width: (multiSelecting == SelectState.selecting)
          ? (MediaQuery.of(context).size.width / 2) - 30
          : (MediaQuery.of(context).size.width / 2.5) - 30,
      child: SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 30,
          child: Stack(alignment: Alignment.center, children: [
            (multiSelecting == SelectState.selecting)
                //^CHECK BOX IF ENABLED
                ? Align(
                    alignment: Alignment.center,
                    child: Transform(
                      transform: Matrix4.translationValues(-55, 0, 0),
                      child: Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> state) =>
                                (!state.contains(MaterialState.selected))
                                    ? Colors.grey.shade600
                                    : highlightColor),
                        value: idToSelected,
                        onChanged: (bool? checkboxValue) async {
                          (checkboxValue! == true)
                              ? selectionCubit.selectFrom(place.id)
                              : selectionCubit.unselectFrom(place.id);
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
                //^IMAGE
            Align(
              alignment: Alignment.centerRight,
              child: Transform(
                transform: Matrix4.translationValues(-12.5, 0, 0),
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 3,
                              spreadRadius: 1.5)
                        ]),
                    child: ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                            fit: BoxFit.fitWidth,
                            image: Image.network(place.getImageUrl,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                              return Image(
                                  fit: BoxFit.fitWidth,
                                  image: Image.network(
                                          'https://i.stack.imgur.com/y9DpT.jpg')
                                      .image);
                            }).image),
                      ),
                    )),
              ),
            ),
            const SizedBox(width: 25),
          ])));
}
