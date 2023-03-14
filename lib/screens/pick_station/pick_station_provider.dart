import 'package:abac_coding_challenge/models/models.dart';
import 'package:abac_coding_challenge/utils/utils.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

/// Provider class for the 'PickStationPage'
/// Handles all business logic behind the 'PickStationPage' screen
class PickStationPageProvider with ChangeNotifier{
  List<PartOrderItem> selectedParts;
  String spaceshipName;
  int spaceshipManufacturingYear;
  DateTime selectedDate;
  Station? selectedStation;
  String searchKeyword = "";
  List<Station> availableStations = [
    Station(
      name: "Station 1",
      price: 300,
      schedule: Station.normalSchedule,
      eta: 180,
      rating: 4
    ),
    Station(
      name: "Station 2",
      price: 400,
      schedule: Station.normalSchedule,
      eta: 150,
      rating: 4.2
    ),
    Station(
      name: "Station 3",
      price: 500,
      schedule: Station.normalSchedule,
      eta: 120,
      rating: 4.8
    ),
    Station(
      name: "Station 4",
      price: 600,
      schedule: Station.normalSchedule,
      eta: 90,
      rating: 4.3
    ),
  ];

  List<Station> sortedStations = [
    Station(
      name: "Station 1",
      price: 300,
      schedule: Station.normalSchedule,
      eta: 180,
      rating: 4
    ),
    Station(
      name: "Station 2",
      price: 400,
      schedule: Station.normalSchedule,
      eta: 150,
      rating: 4.2
    ),
    Station(
      name: "Station 3",
      price: 500,
      schedule: Station.normalSchedule,
      eta: 120,
      rating: 4.8
    ),
    Station(
      name: "Station 4",
      price: 600,
      schedule: Station.normalSchedule,
      eta: 90,
      rating: 4.3
    ),
  ];

  List<Station> displayedStations =[
    Station(
      name: "Station 1",
      price: 300,
      schedule: Station.normalSchedule,
      eta: 180,
      rating: 4
    ),
    Station(
      name: "Station 2",
      price: 400,
      schedule: Station.normalSchedule,
      eta: 150,
      rating: 4.2
    ),
    Station(
      name: "Station 3",
      price: 500,
      schedule: Station.normalSchedule,
      eta: 120,
      rating: 4.8
    ),
    Station(
      name: "Station 4",
      price: 600,
      schedule: Station.normalSchedule,
      eta: 90,
      rating: 4.3
    ),
  ];

  Map<String, bool> sorts = Map.fromIterables(kSorts, kSorts.map((e) => false));

  void updateSortKey(String newKey, bool value){
    /// No sorting criteria is selected, therefore we return to the original order
    if(!value && sorts[newKey]!){
      sorts[newKey] = false;
      sortedStations = List.from(availableStations);
    }
    else {
      for(int i = 0 ; i < sorts.keys.length; i++){
        if(sorts.keys.toList()[i] == newKey) {
          sorts[newKey] = true;
        } else {
          sorts[sorts.keys.toList()[i]] = false;
        }
      }
      switch(newKey){
        case "rating":
          /// Accurate only in case the price contains at most 2 decimals
          sortedStations.sort((station1, station2) => (station2.rating * 100).floor() - (station1.rating * 100).floor());
        break; 
        case "price":
          /// Accurate only in case the price contains at most 2 decimals
          sortedStations.sort((station1, station2) => (station2.price * 100).floor() - (station1.price * 100).floor());
        break; 
        case "eta":
          sortedStations.sort((station1, station2) => station2.eta - station1.eta);
        break;
      }
    }

    displayedStations = List.from(sortedStations);
    search();

    notifyListeners();
  }

  void updateSearchKeyword(String? keyword){
    searchKeyword = keyword ?? "";
    search();

    notifyListeners();
  }

  void search(){
    if(searchKeyword != ""){
      List<Station> tempStations = List.from(sortedStations);
      tempStations.removeWhere((station) => !station.name.toLowerCase().contains(searchKeyword.toLowerCase()));
      displayedStations = List.from(tempStations);
    }

    notifyListeners();
  }

  PickStationPageProvider(this.selectedParts, this.selectedDate, this.spaceshipManufacturingYear, this.spaceshipName);
}