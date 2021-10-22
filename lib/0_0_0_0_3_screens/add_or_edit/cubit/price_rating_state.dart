part of 'price_rating_cubit.dart';

///
///* STATE TO HOLD PRICE AND RATING VALS
///
class PriceRatingState extends Equatable {
  final int price;
  final int rating;

  const PriceRatingState({required this.price, required this.rating});

  @override
  List<Object> get props => [price, rating];
}
