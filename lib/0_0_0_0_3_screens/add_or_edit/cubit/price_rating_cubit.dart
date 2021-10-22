import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_rating_state.dart';

///
///* SIMPLE VALUECHANGE CUBIT ALTERNATIVE FOR CHANGING AND RETRIEVING 
///*     ADD-EDIT RATING AND PRICE VALS
///
class PriceRatingCubit extends Cubit<PriceRatingState> {
  PriceRatingCubit() : super(const PriceRatingState(rating: 1, price: 1));

  void resetPriceRating() {
    emit(const PriceRatingState(rating: 1, price: 1));
  }

  void editPriceRatingWith(
      {required int ratingParam, required int priceParam}) {
    emit(PriceRatingState(rating: ratingParam, price: priceParam));
  }

  void incrementPrice() {
    emit(PriceRatingState(price: state.price + 1, rating: state.rating));
  }

  void decrementPrice() {
    emit(PriceRatingState(price: state.price - 1, rating: state.rating));
  }

  void incrementRating() {
    emit(PriceRatingState(price: state.price, rating: state.rating + 1));
  }

  void decrementRating() {
    emit(PriceRatingState(price: state.price, rating: state.rating - 1));
  }
}
