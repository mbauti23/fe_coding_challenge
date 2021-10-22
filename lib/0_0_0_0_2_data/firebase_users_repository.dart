import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'place/place.dart';
import 'place/place_entity.dart';
import 'user/user.dart';

class FirestoreRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');
  DocumentReference<Map<String, dynamic>>? currentUser;
  CollectionReference? placeCollection;
  String? id;

  FirestoreRepository({String? theID}) {
    id = theID;
    currentUser = FirebaseFirestore.instance.collection("users").doc(id);
  }

  Future<void> addNewUser(User user) {
    return userCollection.doc(user.id).set((user.toEntity().toDocument()));
  }

  Future<void> addNewPlace(Place place) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("places")
        .doc(place.getId)
        .set({
      'id': place.getId,
      'imageUrl': place.getImageUrl,
      'name': place.getName,
      'rating': place.getRating,
      'price': place.getPrice,
    });
  }

  Future<void> deletePlace(Place place) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("places")
        .doc(place.getId)
        .delete();
  }

  Stream<List<Place>> places() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("places")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Place.fromEntity(PlaceEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Stream<Place> getPlace(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(this.id)
        .collection("places")
        .doc(id)
        .snapshots()
        .map((snapshot) {
      return Place.fromEntity(PlaceEntity.fromSnapshot(snapshot));
    });
  }

  Future<void> updatePlace(Place place) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("places")
        .doc(place.getId)
        .update(place.toEntity().toDocument());
  }
}
