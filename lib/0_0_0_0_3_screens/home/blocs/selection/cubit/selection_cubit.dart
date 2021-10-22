import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(const InitialSelectionState(idToSelected: {}));

  void initializeState(Map<String, bool> newMultipleSelected) async {
    emit(IsLoadingSelectionState(idToSelected: newMultipleSelected));
    updateAll();
  }

  ///* UPDATE MAP (MAP NEWMAP)
  ///
  /// Update the map after any filters, sorts, or changes to the database
  /// updateAll() will change the state to notify builders
  ///
  void updateMap(Map<String, bool> newMap) {
    emit(IsLoadingSelectionState(idToSelected: newMap));
    updateAll();
  }

  ///* SELECT FROM (STRING NEWSELECTED)
  ///
  /// Toggle selected for the specific Place, determined by ID param
  ///   [newSelected] passed in.
  /// updateAll() will change the state to notify builders
  ///
  void selectFrom(String newSelected) async {
    emit(IsLoadingSelectionState(
        idToSelected: Map.from((state as LoadedSelectionState).idToSelected
          ..[newSelected] = true)));
    updateAll();
  }

  ///* UNSELECT FROM (STRING NEWSELECTED)
  ///
  /// toggle for the specific Place, determined by ID param
  ///   [newSelected] passed in.
  /// updateAll() will change the state to notify builders
  ///
  void unselectFrom(String newSelected) async {
    emit(IsLoadingSelectionState(
        idToSelected: Map.from((state as LoadedSelectionState).idToSelected
          ..[newSelected] = false)));
    updateAll();
  }

  ///* UNSELECT ALL ()
  ///
  /// toggle unselected for all Places
  /// updateAll() will change the state to notify builders
  ///
  void unselectAll() {
    emit(IsLoadingSelectionState(
        idToSelected: Map.from((state as LoadedSelectionState).idToSelected
          ..updateAll((key, value) => value = false))));
    updateAll();
  }

  ///* SELECT ALL ()
  ///
  /// toggle selected for all Places
  /// updateAll() will change the state to notify builders
  ///
  void selectAll() {
    emit(IsLoadingSelectionState(
        idToSelected: Map.from((state as LoadedSelectionState).idToSelected
          ..updateAll((key, value) => value = true))));
    updateAll();
  }

  ///* UPDATE ALL ()
  ///
  /// Changes state to notify BlocBuilders throughout the application
  ///
  void updateAll() {
    emit(LoadedSelectionState(
        idToSelected: (state as IsLoadingSelectionState).getIdToSelected));
  }

  ///* IS ALL SELECTED ()
  ///
  /// retrieves whether the map contains any values of false
  /// this determines whether or not the select all button has been pressed
  ///
  bool isAllSelected() {
    return !(state as LoadedSelectionState)
        .getIdToSelected
        .containsValue(false);
  }

  ///* IS ALL UNSELECTED ()
  ///
  /// retrieves whether the map contains any values of true
  /// this determines whether or not the unselect all button has been pressed
  ///
  bool isAllUnselected() {
    return !(state as LoadedSelectionState).getIdToSelected.containsValue(true);
  }
}
