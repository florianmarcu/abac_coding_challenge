formatWeekdayToShortWeekday(String weekday) => weekday.substring(0,1).toUpperCase() + weekday.substring(1,3);

int getHourInterval(String startHour, String endHour){
  int interval = int.parse(endHour.substring(0,2)) - int.parse(startHour.substring(0,2));
  return interval;
}