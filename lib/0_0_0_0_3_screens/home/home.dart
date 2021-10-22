import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/filterAndSort/filtered_places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/items/bloc/places_bloc.dart';


///* USED AS ROOT OF FILTEREDPLACESBLOC BEFORE ANY UI IMPLEMENTATION
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FilteredPlacesBloc>(
          create: (context) =>
              FilteredPlacesBloc(placesBloc: context.read<PlacesBloc>()),
          child: const HomeScreenPage()),
    );
  }
}
