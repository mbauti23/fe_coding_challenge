import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///* SIMPLE SPLASH SCREEN COMPONENTS
class SplashComponents extends StatelessWidget {
  const SplashComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: whiteSpaceColor,
            width: double.infinity,
            alignment: Alignment.center,
            child: getTextWidgetWith("Loading...")));
  }

  Widget getTextWidgetWith(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(fontSize: 30, color: mainTextColor));
  }
}
