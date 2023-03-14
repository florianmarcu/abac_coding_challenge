class Station{
  String name;
  double price;
  Map<String, dynamic> schedule;
  int eta;
  double rating;
  
  static Map<String, dynamic> get normalSchedule => {
    "monday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "tuesday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "wednesday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "thursday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "friday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "saturday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
    "sunday": {
      "start-hour": "08:00",
      "end-hour": "16:00"
    },
  };
  
  Station({required this.name, required this.price, required this.schedule, required this.eta, required this.rating});
}