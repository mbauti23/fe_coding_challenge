import 'package:authentication_repository/authentication_repository.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/splash/splash_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


///* SPLASH SCREEN TO SIGN IN
class SplashScreenMain extends StatelessWidget {
  const SplashScreenMain({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SplashScreenMain());

  Future<void> signIn(BuildContext context) async {
    await context.read<AuthenticationRepository>().signIn();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: signIn(context),
      builder: (context, snapshot) {
        //if(snapshot.connectionState == ConnectionState.done)
        return const SplashComponents();
      },
    );
  }
}
