formatWeekdayToShortWeekday(String weekday) => weekday.substring(0,1).toUpperCase() + weekday.substring(1,3);

int getHourInterval(String startHour, String endHour){
  int interval = int.parse(endHour.substring(0,2)) - int.parse(startHour.substring(0,2));
  return interval;
}

String formatHourToHoursAndMinutes(int hour){
  if(hour > 9) {
    return "$hour:00";
  }
  return "0$hour:00";
}

String formatDateToDateAndHour(DateTime date) => "${date.month}.${date.day}.${date.year} ${date.hour>9? date.hour.toString() : "0${date.hour}"}:00";