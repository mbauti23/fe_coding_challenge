import 'package:fe_coding_challenge/0_0_0_0_2_data/place/place.dart';

///
///* SIMPLE IDTOSELECTED MAP INITIALIZER 
///* ALL PLACES ARE UNSELECTED (SET VALUE TO FALSE)
///
Map<String, bool> placesToSelection(List<Place> places) {
  Map<String, bool> newMap = {};
  for (Place place in places) {
    newMap[place.getId] = false;
  }
  return newMap;
}
