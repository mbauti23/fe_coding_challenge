import 'package:fe_coding_challenge/0_0_0_0_0_auth/bloc/auth_bloc.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/splash/splash_screen_dbinit.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/home.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/splash/splash_screen_main.dart';
import 'package:flutter/widgets.dart';

///
///* ON GENERATE APP VIEW PAGES : 
///*    USES AUTHSTATE TO DETERMINE IF AUTHENTICATED, IS IN DB, AND IS ALREADY 
///*    SIGNED IN, SENDS TO APPROPRIATE PAGE
///
List<Page> onGenerateAppViewPages(
    AuthStatus state, List<Page<dynamic>> pages, bool isInDB) {
  switch (state) {
    case AuthStatus.authenticated:
      return (isInDB) ? [HomePage.page()] : [SplashScreenDBInit.page()];
    case AuthStatus.unauthenticated:
      return [SplashScreenMain.page()];
    default:
      return [HomePage.page()];
  }
}
