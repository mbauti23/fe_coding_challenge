import 'package:authentication_repository/authentication_repository.dart';
import 'package:fe_coding_challenge/0_0_0_0_1_routes/splash/splash_components.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/firebase_users_repository.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/user/user.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///* SPLASH SCREEN TO INITIALIZE THE FIRESTORE DB WITH THE NEW USER
class SplashScreenDBInit extends StatelessWidget {
  const SplashScreenDBInit({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SplashScreenDBInit());

  Future<void> initDB(BuildContext context) async {
    final user = context.read<AuthenticationRepository>().currentUser;
    FirestoreRepository fur = FirestoreRepository(theID: user.id);
    await fur.addNewUser(User(id: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initDB(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const HomePage();
        }
        return const SplashComponents();
      },
    );
  }
}
