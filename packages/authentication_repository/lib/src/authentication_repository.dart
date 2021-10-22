import 'dart:async';
import 'package:authentication_repository/src/models/user_initial.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../authentication_repository.dart';

/// Thrown if during the sign in process if a failure occurs.
class SignInFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

///
/// Manages user authentication.
///
class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Stream of [AnonUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AnonUser.empty] if the user is not authenticated.
  Stream<AnonUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AnonUser.empty : firebaseUser.toUser;
      return user;
    });
  }

  /// Returns the current user.
  /// Defaults to [AnonUser.empty] if there is no user.
  AnonUser get currentUser {
    if (firebase_auth.FirebaseAuth.instance.currentUser == null)
      return AnonUser.empty;
    return firebase_auth.FirebaseAuth.instance.currentUser!.toUser;
  }

  /// Creates a new anonymous user.
  ///
  /// Throws a [SignInFailure] if an exception occurs.
  Future<void> signIn() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on Exception {
      throw SignInFailure();
    }
  }
}

extension on firebase_auth.User {
  AnonUser get toUser {
    return AnonUser(id: uid, places: []);
  }
}

