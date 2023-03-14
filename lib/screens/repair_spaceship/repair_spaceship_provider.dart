import 'package:abac_coding_challenge/models/models.dart';
import 'package:abac_coding_challenge/screens/pick_station/pick_station_page.dart';
import 'package:abac_coding_challenge/screens/pick_station/pick_station_provider.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/components/repair_spaceship_step_change_parts.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/components/repair_spaceship_step_select_date.dart';
import 'package:abac_coding_challenge/utils/utils.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

/// Provider class for the 'RepairSpaceshipPage'
/// Handles all business logic behind the 'RepairSpaceshipPage' screen
class RepairSpaceshipPageProvider with ChangeNotifier{
  List<Step> steps = [
    Step(
      label: SizedBox(
        width: 100,
        child: Text("Creează deviz", textAlign: TextAlign.center, style: TextStyle(fontSize: 15),)
      ),
      isActive: true,
      title: Container(),
      content: RepairSpaceshipStepChangeParts()
    ),
    Step(
      label: SizedBox(
        width: 100,
        child: Text("Stabilește ora", textAlign: TextAlign.center, style: TextStyle(fontSize: 15),)
      ),
      title: Container(), 
      content: RepairSpaceshipStepSelectDate()
    )
  ];
  List<Part> availableParts = [
    Part(
      name: "Rulmeant",
      pricePerUnit: 10,
    ),
    Part(
      name: "Tobă sport",
      pricePerUnit: 1000,
    ),
    Part(
      name: "Cauciuc",
      pricePerUnit: 300,
    )
  ];
  DateTime today = DateTime.now().toLocal();
  DateTime selectedDate = DateTime(DateTime.now().toLocal().year, DateTime.now().toLocal().month, DateTime.now().toLocal().day);
  DateTime focusedDate = DateTime(DateTime.now().toLocal().year, DateTime.now().toLocal().month, DateTime.now().toLocal().day);
  int selectedHour = 0; /// The index of the selected hour (starting from the first hour of the schedule "08:00")
  // int 
  int displayedMonth = DateTime.now().toLocal().month;
  int displayedYear = DateTime.now().toLocal().year;
  
  bool isLoading = false;
  int currentStep = 0;
  String currentPartName = "";
  int currentPartQuantity = 1;
  GlobalKey<FormState> formKey = GlobalKey();
  // CalendarWeekController calendarWeekController = CalendarWeekController();


  List<PartOrderItem> selectedParts = [];

  RepairSpaceshipPageProvider();

  void updateActiveStep(int index){
    for (var i = 0; i < steps.length; i++) {
      steps[i] = Step(
        label: steps[i].label,
        title: steps[i].title,
        content: steps[i].content,
        isActive: i == index? true : false
      );
    }

    notifyListeners();
  }

  void incrementCurrentStep(){
    if(currentStep < steps.length - 1){
      currentStep++;

      updateActiveStep(currentStep);
    }
    notifyListeners();
  }

  void updateCurrentStep(int step){
    currentStep = step;

    updateActiveStep(currentStep);

    notifyListeners();
  }

  void removePart(PartOrderItem part){
    selectedParts.remove(part);

    notifyListeners();
  }

  void updateCurrentPartName(String? partName){
    currentPartName = partName ?? "";

    notifyListeners();
  }

  void updateCurrentPartQuantity(String? quantity){
    if(quantity != null){
      currentPartQuantity = int.tryParse(quantity) ?? -1;
    }

    notifyListeners();
  }

  void addPart(BuildContext context){
    if(formKey.currentState != null){
      if(formKey.currentState!.validate()){
        if(!selectedParts.any((pastOrderItem) => pastOrderItem.name == currentPartName)){
          var part = availableParts.firstWhere((part) => currentPartName == part.name);
          selectedParts.add(PartOrderItem(name: currentPartName, quantity: currentPartQuantity, pricePerUnit: part.pricePerUnit, totalPrice: part.pricePerUnit * currentPartQuantity));
        }
        else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Componenta se afla deja pe lista"),));
        }
      }
    }

    notifyListeners();
  }

  void updateDisplayedMonthAndYear(int month){
    switch(month){
      case 12:
        displayedMonth = 0;
        displayedYear += 1;
      break;
      case -1:
        displayedMonth = 11;
        displayedYear -= 1;
      break;
      default:
        displayedMonth = month;
    }

    notifyListeners();
  }

  void onDateChanged(DateTime date){}

  bool checkDateAvailable(int index, String weekday){
    var weekdayIndex = kWeekdayToIndex[weekday]!;
    var newDate = DateTime(focusedDate.year, focusedDate.month, focusedDate.day)
    .add(Duration(days: weekdayIndex - focusedDate.weekday + 1));
    if(today.difference(newDate) >= Duration(days: 1)){
      return false;
    }
    return true;
  }

  void updateSelectedDate(int index, String weekday){
    selectedHour = index;
    var weekdayIndex = kWeekdayToIndex[weekday]!;
    selectedDate = DateTime(focusedDate.year, focusedDate.month, focusedDate.day)
    .add(Duration(days: weekdayIndex - focusedDate.weekday + 1));
    notifyListeners();
  }

  void updateFocusedDate(DateTime focusedDay){
    focusedDate = DateTime(focusedDay.year, focusedDay.month, focusedDay.day);

    notifyListeners(); 
  }

  String? validatePartName(String? partName){
    try{
      availableParts.firstWhere((part) => (partName == null ? "" : partName.toLowerCase()) == part.name.toLowerCase());
    }
    catch(error){
      return "Componenta nu există";
    }
    return null;
  }

  String? validateQuantity(String? quantity){
    if((int.tryParse(quantity ?? "") != null ? int.parse(quantity ?? "0") : 0 )< 0 ){
      return "Cantitate invalida";
    }
    return null;
  }

  Widget controlsBuilder(BuildContext context, ControlsDetails controlsDetails){
    int currentStep = controlsDetails.currentStep;
    /// Stepper is on the last step and has more than 1 step
    if(controlsDetails.currentStep == steps.length - 1 && controlsDetails.currentStep > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text("ÎNAPOI"),
            onPressed: () => updateCurrentStep(currentStep - 1),
          ),
          TextButton(
            child: Text("CREEAZĂ"),
            onPressed: () => finishStepper(context),
          )
        ],
      );
    } else if(controlsDetails.currentStep == steps.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text("CREEAZĂ"),
            onPressed: () => finishStepper(context),
          )
        ],
      );
    } else if(controlsDetails.currentStep == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text("ÎNAINTE"),
            onPressed: () => updateCurrentStep(currentStep + 1),
          )
        ],
      );
    }
    else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text("ÎNAPOI"),
            onPressed: () => updateCurrentStep(currentStep - 1),
          ),
          TextButton(
            child: Text("ÎNAINTE"),
            onPressed: () => updateCurrentStep(currentStep + 1),
          )
        ],
      );
    }
  }

  finishStepper(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => PickStationPageProvider(
            selectedParts, /// The 'parts' selected by the user
            DateTime( /// The 'date' selected by the user
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              int.parse(Station.normalSchedule[Station.normalSchedule.keys.toList()[selectedDate.weekday - 1]]['start-hour'].substring(0,2)) + selectedHour
            ),
            2007, /// The spaceship's manufacturing year (hardcoded)
            "SEAT Ibiza" /// The spaceship's name (hardcoded)
        ),
         child: PickStationPage(),
      )
    ));
  }
}