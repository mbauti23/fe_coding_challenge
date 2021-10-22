part of 'auth_bloc.dart';


///^ AUTH EVENT
///
/// Logged In event to transfer user to state
///
@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  const LoggedIn(this.user);
  final AnonUser user;

  @override
  List<Object> get props => [user];
}

