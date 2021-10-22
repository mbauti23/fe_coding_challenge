import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///* PLACE ENTITY
///
/// The conversion class for uploading a Place to firestore
///
class PlaceEntity extends Equatable {
  final String id;
  final String imageUrl; // Random image url from https://picsum.photos/
  final String name;
  final int rating; // 1, 2, 3, 4, or 5
  final String price; // '$', '$$', '$$$'

  const PlaceEntity({
    required String id2,
    required String imageUrl2,
    required String name2,
    required int rating2,
    required String price2,
  })  : id = id2,
        imageUrl = imageUrl2,
        name = name2,
        rating = rating2,
        price = price2;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'rating': rating,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'PlaceEntity {id: $id, imageUrl: $imageUrl, name: $name, rating: $rating, price: $price}';
  }

  static PlaceEntity fromJson(Map<String, Object> json) {
    return PlaceEntity(
      id2: json['id'] as String,
      imageUrl2: json['imageUrl'] as String,
      name2: json['name'] as String,
      rating2: json['rating'] as int,
      price2: json['price'] as String,
    );
  }

  static PlaceEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map;
    return PlaceEntity(
      id2: data['id'] ?? "NULL",
      imageUrl2: data['imageUrl'] ?? "NULL",
      name2: data['name'] ?? "NULL",
      rating2: data['rating'] ?? 0,
      price2: data['price'] ?? "NULL",
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'rating': rating,
      'price': price,
    };
  }

  get getId => id;
  get getImageUrl => imageUrl;
  get getName => name;
  get getRating => rating;
  get getPrice => price;

  @override
  List<Object?> get props => [id, imageUrl, name, rating, price];
}
