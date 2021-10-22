part of 'places_bloc.dart';

///* PLACES STATES
///
///^ Loading: Places have not been retrieved from Firestore yet.
///^ Loaded: Places have been retrieved.
///^ NotLoaded: Error state.
///

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;
  const PlacesLoaded(
    this.places,
  );

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesLoaded { places: $places }';
}

class PlacesNotLoaded extends PlacesState {}
