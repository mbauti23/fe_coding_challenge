import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/bar/app_bar.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/sel_button_column.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/filtered_places_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///* UI IMPLEMENTATION OF HOME PAGE 
///
///^ INCLUDING:
///^      APPBAR
///^      BUTTONS ON SELECTION
///^      FILTERED PLACES (LIST OF PLACES WITH FILTER AND SORT)
class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(children: [
      Positioned(
          top: 136.0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 135,
            width: MediaQuery.of(context).size.width,
            child: const FilteredPlaces(),
          )),
      customAppBar(context),
      const SelectionButtonColumn(),
    ]));
  }
}
