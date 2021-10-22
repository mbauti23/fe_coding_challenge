import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/selection/cubit/selection_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/util/custom_clipper.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* THE SELECTION BUTTONS DISPLAYED DURING SELECTION
///* DYNAMIC COLOR CHANGING IMPLEMENTATION FOR CHECKMARK ICON ((UN)SELECT ALL)
///
class SelectionButton extends StatelessWidget {
  const SelectionButton(
      {Key? key,
      required this.iconForButton,
      required this.buttonHighlight,
      required this.onTap})
      : super(key: key);

  final IconData iconForButton;
  final Color buttonHighlight;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      onTap: onTap,
      child: SizedBox(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            decoration:
                const BoxDecoration(color: footerColor, shape: BoxShape.circle),
            height: 80,
            width: 80,
            child: ClipOval(
                clipper: MyCustomClipper2(),
                child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(color: buttonHighlight))),
          ),
          //^DYNAMIC COLOR IMPLEMENTATION FOR (UN)SELECT ALL ICON
          (iconForButton == Icons.check_box)
              ? BlocBuilder<SelectionCubit, SelectionState>(
                  builder: (context, state) {
                    return Icon(iconForButton,
                        color: BlocProvider.of<SelectionCubit>(context)
                                .isAllSelected()
                            ? highlightColor
                            : whiteSpaceColor,
                        size: 32);
                  },
                )
              : Icon(iconForButton, color: whiteSpaceColor, size: 32),
        ]),
      ),
    );
  }
}
