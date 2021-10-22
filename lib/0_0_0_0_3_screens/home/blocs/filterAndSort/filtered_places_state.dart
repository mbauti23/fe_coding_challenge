part of 'filtered_places_bloc.dart';

///* ALL IN ONE ENUM TO SPECIFY CURRENT SORT FOR ENTIRE LIST
enum SortState {
  defaultSort,
  ratingAscending,
  ratingDescending,
  priceAscending,
  priceDescending,
}

///* DETERMINES WHETHER OR NOT LONG PRESS HAPPENED AND ARE SELECTING
enum SelectState { selecting, notSelecting }


abstract class FilteredPlacesState extends Equatable {
  const FilteredPlacesState();
  @override
  List<Object> get props => [];
}


class FilteredPlacesLoading extends FilteredPlacesState {}

//* STATE TO RETRIEVE FROM 
class FilteredPlacesLoaded extends FilteredPlacesState {
  final List<Place> filteredPlaces;
  final String activeFilter;
  final SortState theOrder;
  final SelectState selectState;

  const FilteredPlacesLoaded(
      this.filteredPlaces, this.activeFilter, this.theOrder, this.selectState);

  @override
  List<Object> get props => [filteredPlaces, activeFilter, theOrder, selectState];

  @override
  String toString() {
    return 'FilteredPlacesLoaded { filteredPlaces: $filteredPlaces, activeFilter: $activeFilter, theOrder: $theOrder, selectType: $selectState}';
  }
}
