import 'package:authentication_repository/src/models/place.dart';
import 'package:equatable/equatable.dart';

///* ANON USER 
///
/// The various attributes that make up the user
///
class AnonUser extends Equatable {
  const AnonUser({
    required this.id,
    this.places,
  });

  /// The current user's id.
  final String id;

  /// The list of places for a user.
  final List<Place>? places;

  /// Empty user which represents an unauthenticated user.
  static const empty = AnonUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AnonUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AnonUser.empty;

  @override
  List<Object?> get props => [id, places];
}
