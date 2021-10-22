// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///* ANON USER ENTITY 
///
/// The conversion class for uploading a User to firestore
///
class AnonUserEntity extends Equatable {
  final String id;

  const AnonUserEntity({
    required this.id,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
    };
  }

  @override
  List<Object?> get props => [
        id,
      ];

  @override
  String toString() {
    return 'UserEntity {id: $id}';
  }

  static AnonUserEntity fromJson(Map<String, Object> json) {
    return AnonUserEntity(
      id: json['id'] as String,
    );
  }

  static AnonUserEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map;
    return AnonUserEntity(
      id: data['id'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
    };
  }
}
