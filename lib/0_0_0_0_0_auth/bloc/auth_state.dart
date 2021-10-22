part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

///^ AUTH STATE
///
/// State with current status and user
///
class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = AnonUser.empty,
  });

  const AuthState.authenticated(AnonUser user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final AnonUser user;

  @override
  List<Object> get props => [status, user];
}
