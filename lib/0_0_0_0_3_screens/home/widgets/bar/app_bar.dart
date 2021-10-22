import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/end_bar_actions.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/leading_bar_action.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/bar/search_filter_bar.dart';
import 'package:fe_coding_challenge/0_0_0_0_4_constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///* APP BAR FOR HOME SCREEN
///
///^ INCLUDES:
///^    LEADING ACTION BUTTON
///^    FILTER SEARCH BAR
///^    TRAILING ACTION BUTTONS
///
Widget customAppBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: footerColor,
          child: Center(
            child: Transform(
              transform: Matrix4.translationValues(0, -10, 0),
              child: Text("Places",
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
            ),
            //),
          ),
          height: 136.68571428571428,
          width: MediaQuery.of(context).size.width,
        ),
        Container(), // Raise the Positioned
        Positioned(
          top: 100.0,
          left: 10.0,
          right: 10.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppBar(
                backgroundColor: highlightColor,
                leading: leadingActionButton(),
                primary: false,
                title: const FilterBar(),
                actions: appBarActions()),
          ),
        )
      ],
    );
  }