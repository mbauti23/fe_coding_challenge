part of 'selection_cubit.dart';

///* SELECTION STATES
///
///^ Initial: Places have not been retrieved from Firestore yet.
///^ IsLoading: Used to notify builders that states are changing.
///^ Loaded: The final state value. This is where data can be retrieved
///

class SelectionState extends Equatable {
  const SelectionState();
  @override
  List<Object?> get props => [];
}

class InitialSelectionState extends SelectionState {
  final Map<String, bool> idToSelected;
  const InitialSelectionState({required this.idToSelected});
  @override
  List<Object> get props => [idToSelected];
}

class IsLoadingSelectionState extends SelectionState {
  final Map<String, bool> idToSelected;

  const IsLoadingSelectionState({required this.idToSelected});

  Map<String, bool> get getIdToSelected => idToSelected;

  IsLoadingSelectionState copyWith({Map<String, bool>? idToSelected2}) {
    return IsLoadingSelectionState(idToSelected: idToSelected2 ?? idToSelected);
  }
}

class LoadedSelectionState extends SelectionState {
  final Map<String, bool> idToSelected;

  const LoadedSelectionState({required this.idToSelected});

  Map<String, bool> get getIdToSelected => idToSelected;

  LoadedSelectionState copyWith({Map<String, bool>? idToSelected2}) {
    return LoadedSelectionState(idToSelected: idToSelected2 ?? idToSelected);
  }

  @override
  List<Object> get props => [idToSelected];
}
