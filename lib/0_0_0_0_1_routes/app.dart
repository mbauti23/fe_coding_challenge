import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_coding_challenge/0_0_0_0_0_auth/bloc/auth_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/routes.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/splash/splash_components.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/firebase_users_repository.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/add_or_edit/cubit/price_rating_cubit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/items/bloc/places_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/selection/cubit/selection_cubit.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';


///
///* APP : DECLARES THE INITIAL BLOC PROVIDER TO 
///*    GET AUTH VALUE, THEN PRECEEDS TO APPDIRECT
///
class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppDirect(),
      ),
    );
  }
}

///
///* APP DIRECT : DECLARES THE NECESSARY BLOC PROVIDERS, WRAPS WITH VERY 
///*    USEFUL RESPONSIVE-FRAMEWORK WIDGET, AND CHECKS TO SEE IF THE CURRENT
///*    USER IS IN THE DATABASE ALREADY
///
class AppDirect extends StatelessWidget {
  final Color wht = Colors.white;

  AppDirect({Key? key}) : super(key: key);

  final todoCollection = FirebaseFirestore.instance.collection('users');

  //CHECK IF IN DB
  Future<bool> direct(BuildContext context) async {
    bool result = false;
    try {
      final user = context.select((AuthBloc bloc) => bloc.state.user);

      final doc = await todoCollection.doc(user.id).get();
      return doc.exists;
    } catch (e) {
      //print("ERROR: $e");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 800,
            minWidth: 400,
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(
              color: const Color(0xFFDDDDDD),
            )),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PlacesBloc>(
              create: (context) {
                return PlacesBloc(
                  placesRepository: FirestoreRepository(
                      theID: context.read<AuthBloc>().state.user.id),
                )..add(LoadPlaces());
              },
            ),
            BlocProvider<SelectionCubit>(
              create: (BuildContext context) => SelectionCubit(),
            ),
            BlocProvider<PriceRatingCubit>(
              create: (BuildContext context) => PriceRatingCubit(),
            ),
          ],
          child: FutureBuilder<bool>(
              future: direct(context),//IF IN DB
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return FlowBuilder<AuthStatus>(
                    state: context.select((AuthBloc bloc) => bloc.state.status),
                    onGeneratePages: (state, pages) =>
                        onGenerateAppViewPages(state, pages, snapshot.data!),
                  );
                }

                return const SplashComponents();
              }),
        ));
  }
}
