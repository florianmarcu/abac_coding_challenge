import 'package:abac_coding_challenge/models/models.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/components/repair_spaceship_step_change_parts.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/components/repair_spaceship_step_select_date.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

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

  List<Station> availableStations = [
    Station(
      name: "Station 1",
      price: 300,
      schedule: Station.normalSchedule,
      eta: 180
    ),
    Station(
      name: "Station 2",
      price: 400,
      schedule: Station.normalSchedule,
      eta: 150
    ),
    Station(
      name: "Station 3",
      price: 500,
      schedule: Station.normalSchedule,
      eta: 120
    ),
    Station(
      name: "Station 4",
      price: 600,
      schedule: Station.normalSchedule,
      eta: 90
    ),
  ];

  DateTime today = DateTime.now().toLocal();
  DateTime selectedDate = DateTime.now().toLocal();
  // int 
  int displayedMonth = DateTime.now().toLocal().month;
  int displayedYear = DateTime.now().toLocal().year;
  
  bool isLoading = false;
  int currentStep = 0;
  String currentPartName = "";
  int currentPartQuantity = 1;
  GlobalKey<FormState> formKey = GlobalKey();
  // CalendarWeekController calendarWeekController = CalendarWeekController();


  List<PartOrderItem> parts = [];

  RepairSpaceshipPageProvider(){
    getData();
  }

  void getData(){
    _loading();

    _loading();
  }

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
    parts.remove(part);

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

  void addPart(){
    if(formKey.currentState != null){
      if(formKey.currentState!.validate()){
        var part = availableParts.firstWhere((part) => currentPartName == part.name);
        parts.add(PartOrderItem(name: currentPartName, quantity: currentPartQuantity, pricePerUnit: part.pricePerUnit, totalPrice: part.pricePerUnit * currentPartQuantity));
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
            onPressed: () => finishStepper(),
          )
        ],
      );
    } else if(controlsDetails.currentStep == steps.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text("CREEAZĂ"),
            onPressed: () => finishStepper(),
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

  finishStepper(){

  }

  /// Method that notifies the page that the app is processing data
  _loading(){
    isLoading = !isLoading;

    notifyListeners();
  }
}