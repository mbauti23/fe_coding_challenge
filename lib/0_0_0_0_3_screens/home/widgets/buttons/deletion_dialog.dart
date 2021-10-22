import 'dart:ui';

import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/selection_button.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';


///* SIMPLE DIALOG SHOWN TO CONFIRM USERS DECISION TO DELETE A PLACE
///*    BUTTONS PASSED IN TO USE ONTAPS AND VISUAL ELEMENTS
//
//Bug: Heros currently not animating
///
///
class DeletionDialog extends StatelessWidget {
  const DeletionDialog(
      {Key? key,
      required this.closeButton,
      required this.deleteButton,
      required this.closeTag,
      required this.deleteTag})
      : super(key: key);

  final SelectionButton closeButton;
  final SelectionButton deleteButton;
  final String closeTag;
  final String deleteTag;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              decoration: BoxDecoration(
                  color: whiteSpaceColor,
                  borderRadius: BorderRadius.circular(10)),
              height: 250,
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text("Confirm deletion?", style: TextStyle(fontSize: 28)),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(children: [
                    Hero(tag: closeTag, child: closeButton),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const SizedBox(width: 80, height: 80)),
                  ]),
                  const SizedBox(width: 20),
                  Stack(children: [
                    Hero(tag: deleteTag, child: deleteButton),
                    InkWell(
                        onTap: () {
                          deleteButton.onTap();
                          Navigator.of(context).pop();
                        },
                        child: const SizedBox(width: 80, height: 80)),
                  ]),
                ]),
              ]),
            )));
  }
}
