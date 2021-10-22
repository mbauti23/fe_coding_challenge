import 'package:equatable/equatable.dart';


///* PLACE 
///
/// The various attributes that make up the place
///
class Place extends Equatable {
  final String id;
  final String imageUrl; // Random image url from https://picsum.photos/
  final String name;
  final int rating; // 1, 2, 3, 4, or 5
  final String price; // '$', '$$', '$$$'

  const Place({
    required String idParam,
    required String imageUrlParam,
    required String nameParam,
    required int ratingParam,
    required String priceParam,
  })  : id = idParam,
        imageUrl = imageUrlParam,
        name = nameParam,
        rating = ratingParam,
        price = priceParam;

  Place copyWith({
    String? idCopyParam,
    String? imageUrlCopyParam,
    String? nameCopyParam,
    int? ratingCopyParam,
    String? priceCopyParam,
  }) {
    return Place(
        idParam: idCopyParam ?? id,
        imageUrlParam: imageUrlCopyParam ?? imageUrl,
        nameParam: nameCopyParam ?? name,
        ratingParam: ratingCopyParam ?? rating,
        priceParam: priceCopyParam ?? price);
  }

  String get getId => id;
  String get getImageUrl => imageUrl;
  String get getName => name;
  int get getRating => rating;
  String get getPrice => price;

  @override
  String toString() {
    return 'Place {id: $id, imageUrl: $imageUrl, name: $name, rating: $rating, price: $price}';
  }

  @override
  List<Object?> get props => [id, imageUrl, name, rating, price];
}
