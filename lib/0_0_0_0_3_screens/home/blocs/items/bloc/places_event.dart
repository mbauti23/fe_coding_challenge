part of 'places_bloc.dart';

///* PLACES EVENT
///
///^ LoadPlaces: Start retrieving Places.
///^ PlacesUpdated: Places have been retrieved and updated.
///^ AddPlace: Add a Place to the db.
///^ UpdatePlace: Update Place within the db.
///^ DeletePlace: Delete Place from the db.
///^ DeleteSelected: Delete all selected places from the db.

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaces extends PlacesEvent {}

class AddPlace extends PlacesEvent {
  final Place place;
  const AddPlace(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'AddPlace { place: $place }';
}

class UpdatePlace extends PlacesEvent {
  final Place updatedPlace;

  const UpdatePlace(this.updatedPlace);

  @override
  List<Object> get props => [updatedPlace];

  @override
  String toString() => 'UpdatePlace { updatedPlace: $updatedPlace }';
}

class DeletePlace extends PlacesEvent {
  final Place place;

  const DeletePlace(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'DeletePlace { place: $place }';
}

class DeleteSelected extends PlacesEvent {
  final Map<String, bool> idToSelected;
  const DeleteSelected(this.idToSelected);

  @override
  List<Object> get props => [idToSelected];

  @override
  String toString() => 'DeletePlace { idToSelected: $idToSelected }';
}

class PlacesUpdated extends PlacesEvent {
  final List<Place> places;

  const PlacesUpdated(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesUpdated { Place: $places }';
}
