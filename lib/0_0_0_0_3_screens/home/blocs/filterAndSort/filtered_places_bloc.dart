import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/items/bloc/places_bloc.dart';

part 'filtered_places_event.dart';
part 'filtered_places_state.dart';

///
///
///*Used for retrieving places using a text filter
///
///
class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final PlacesBloc _placesBloc;
  late StreamSubscription _placesSubscription;

  FilteredPlacesBloc({required PlacesBloc placesBloc})
      : _placesBloc = placesBloc,
        super(
          placesBloc.state is PlacesLoaded
              ? FilteredPlacesLoaded(
                  (placesBloc.state as PlacesLoaded).places,
                  "",
                  SortState.defaultSort,
                  SelectState.notSelecting,
                )
              : FilteredPlacesLoading(),
        ) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdatePlaces>(_onUpdatePlaces);

    _placesSubscription = placesBloc.stream.listen((placeState) {
      if (placeState is PlacesLoaded) add(UpdatePlaces(placeState.places));
    });
  }

  ///
  ///*Updates places with a new text filter
  ///
  void _onUpdateFilter(UpdateFilter event, Emitter<FilteredPlacesState> emit) {
    final state = _placesBloc.state;
    if (state is PlacesLoaded) {
      emit(FilteredPlacesLoaded(
          _mapPlacesToFilteredPlaces(
              state.places, event.filter, event.theOrder, event.selectState),
          event.filter,
          event.theOrder,
          event.selectState));
    }
  }

  ///
  ///*Updates places while maintaining the text value
  ///
  void _onUpdatePlaces(UpdatePlaces event, Emitter<FilteredPlacesState> emit) {
    final state = this.state;
    final filter = state is FilteredPlacesLoaded ? state.activeFilter : "";
    final theOrder =
        state is FilteredPlacesLoaded ? state.theOrder : SortState.defaultSort;
    final selectState = state is FilteredPlacesLoaded
        ? state.selectState
        : SelectState.notSelecting;
    emit(
      FilteredPlacesLoaded(
          _mapPlacesToFilteredPlaces((_placesBloc.state as PlacesLoaded).places,
              filter, theOrder, selectState),
          filter,
          theOrder,
          selectState),
    );
  }

  ///
  ///*Uses the text filter to retrieve places containing the string
  ///*Order the list based on theOrder value
  ///
  List<Place> _mapPlacesToFilteredPlaces(
    List<Place> places,
    String filter,
    SortState theOrder,
    SelectState selectState,
  ) {
    //^FILTER
    final placeList = places.where((place) {
      return place.getName
          .toLowerCase()
          .trim()
          .contains(filter.toLowerCase().trim());
    }).toList();

    //^ORDER
    switch (theOrder) {
      case SortState.priceAscending:
        return placeList
          ..sort((Place a, Place b) =>
              a.getPrice.length.compareTo(b.getPrice.length));
      case SortState.priceDescending:
        List<Place> reversed = placeList
          ..sort((Place a, Place b) =>
              a.getPrice.length.compareTo(b.getPrice.length));
        reversed = List.from(reversed.reversed);
        return reversed;
      case SortState.ratingAscending:
        return placeList
          ..sort((Place a, Place b) => a.getRating.compareTo(b.getRating));
      case SortState.ratingDescending:
        List<Place> reversed = placeList
          ..sort((Place a, Place b) => a.getRating.compareTo(b.getRating));
        reversed = List.from(reversed.reversed);
        return reversed;
      default:
        return placeList;
    }
  }

  @override
  Future<void> close() {
    _placesSubscription.cancel();
    return super.close();
  }
}
