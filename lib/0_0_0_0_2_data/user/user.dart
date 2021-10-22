import 'package:meta/meta.dart';
import 'user_entity.dart';

///* User 
///
/// The various attributes that make up a User object
///
@immutable
class User {
  final String id;

  const User({
    required this.id,
  });

  @override
  String toString() {
    return 'User{id: $id}';
  }

  AnonUserEntity toEntity() {
    return AnonUserEntity(
      id: id,
    );
  }

  static User fromEntity(AnonUserEntity entity) {
    return User(
      id: entity.id,
    );
  }
}
