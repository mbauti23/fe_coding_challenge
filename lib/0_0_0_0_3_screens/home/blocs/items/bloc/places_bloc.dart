import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/firebase_users_repository.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';

part 'places_event.dart';
part 'places_state.dart';

///^ PLACES BLOC
///
/// Management of Place changes
///
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc({required FirestoreRepository placesRepository})
      : _placesRepository = placesRepository,
        super(PlacesLoading()) {
    on<LoadPlaces>(_onLoadPlaces);
    on<AddPlace>(_onAddPlace);
    on<UpdatePlace>(_onUpdatePlace);
    on<DeletePlace>(_onDeletePlace);
    on<PlacesUpdated>(_onPlacesUpdated);
    on<DeleteSelected>(_onDeleteSelected);
  }

  final FirestoreRepository _placesRepository;

  Future<void> _onLoadPlaces(LoadPlaces event, Emitter<PlacesState> emit) {
    return emit.onEach<List<Place>>(
      _placesRepository.places(),
      onData: (places) => add(PlacesUpdated(places)),
    );
  }

  ///* ON ADD PLACE
  ///
  /// Add the place via placesRepository
  ///
  void _onAddPlace(AddPlace event, Emitter<PlacesState> emit) {
    _placesRepository.addNewPlace(event.place);
  }

  ///* ON UPDATE PLACE
  ///
  /// Update the place via placesRepository
  ///
  void _onUpdatePlace(UpdatePlace event, Emitter<PlacesState> emit) async {
    await _placesRepository.updatePlace(event.updatedPlace);
  }

  ///* ON DELETE PLACE
  ///
  /// delete the place via placesRepository
  ///
  void _onDeletePlace(DeletePlace event, Emitter<PlacesState> emit) {
    _placesRepository.deletePlace(event.place);
  }

  ///* ON PLACES UPDATED
  ///
  /// Update the place via placesRepository
  ///
  void _onPlacesUpdated(PlacesUpdated event, Emitter<PlacesState> emit) {
    emit(PlacesLoaded(event.places));
  }

  ///* ON DELETE SELECTED
  ///
  /// Delete all places that are selected, determined by bool values in Map
  ///
  void _onDeleteSelected(DeleteSelected event, Emitter<PlacesState> emit) {
    final currentState = state;
    if (currentState is PlacesLoaded) {
      final List<Place> placesToDelete = currentState.places
          .where((place) => event.idToSelected[place.getId]! == true)
          .toList();
      for (var deletedPlace in placesToDelete) {
        _placesRepository.deletePlace(deletedPlace);
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
