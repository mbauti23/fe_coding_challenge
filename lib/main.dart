import 'package:fe_coding_challenge/0_0_0_0_1_routes/app.dart';
//import 'package:fe_coding_challenge/0_0_0_0_0_auth/bloc_observer.dart';
//import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() async {
  //Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  //INITIALIZE FIREBASE
  await Firebase.initializeApp();
  //AUTH REPOSITORY FOR GRABBING USER OR SIGNING IN A NEW ONE
  final auth = AuthenticationRepository();
  runApp(App(
    authenticationRepository: auth,
  ));
}
