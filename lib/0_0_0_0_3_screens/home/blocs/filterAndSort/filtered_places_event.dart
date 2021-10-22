part of 'filtered_places_bloc.dart';

abstract class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();
}

///
///* FILTER AND SORT UPDATE EVENT
///
class UpdateFilter extends FilteredPlacesEvent {

  final String filter; //THE ACTIVE FILTER FOR ENTIRE LIST
  final SortState theOrder; //THE ACTIVE ORDER FOR ENTIRE LIST
  final SelectState selectState;  //THE ACTIVE SELECTION STATE FOR ENTIRE LIST

  const UpdateFilter(this.filter, this.theOrder, this.selectState);

  @override
  List<Object> get props => [filter, theOrder, selectState];

  @override
  String toString() =>
      'UpdateFilter { filter: $filter, theOrder: $theOrder, selectState: $selectState}';
}


///
///* PLACE UPDATE EVENT
///
class UpdatePlaces extends FilteredPlacesEvent {
  final List<Place> places;

  const UpdatePlaces(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'UpdatePlaces { places: $places }';
}
