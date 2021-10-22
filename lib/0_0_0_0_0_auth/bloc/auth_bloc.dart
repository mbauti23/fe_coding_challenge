import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';


///^ AUTH BLOC
///
/// Management of User changes
///
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _auth;
  late final StreamSubscription<AnonUser> _userSubscription;

  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _auth = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    //IF USER CHANGES, ADD LOGGED IN EVENT      
    _userSubscription = _auth.user.listen(_onUserLoggedIn);
  }

  void _onUserLoggedIn(AnonUser user) => add(LoggedIn(user));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoggedIn) {
      yield _mapUserChangedToState(event, state);
    }
  }

  AuthState _mapUserChangedToState(LoggedIn event, AuthState state) {
    return (event.user.isNotEmpty)
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
