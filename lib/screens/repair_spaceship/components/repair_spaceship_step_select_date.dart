import 'package:abac_coding_challenge/models/models.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_provider.dart';
import 'package:abac_coding_challenge/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


/// Widget for the second step of the Stepper
/// Contains a calendar built with 'table_calendar' package
class RepairSpaceshipStepSelectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RepairSpaceshipPageProvider>();
    return Column(
      children: [
        TableCalendar(
          onPageChanged: (focusedDay) => provider.updateFocusedDate(focusedDay),
          calendarStyle: CalendarStyle(
            
            cellMargin: EdgeInsets.only(left: 1, right: 3),
            cellAlignment: Alignment.centerLeft,
            cellPadding: EdgeInsets.zero,
            tablePadding: EdgeInsets.zero,
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            ),
            
            // isTodayHighlighted: false,
            rangeHighlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            weekendTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            defaultTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            disabledTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            outsideTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            selectedTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            todayTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            ),
          ),
          daysOfWeekHeight: 15,
          currentDay: provider.selectedDate,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary)
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const { CalendarFormat.week: "week"},
          calendarFormat: CalendarFormat.week,
          focusedDay: provider.focusedDate, 
          firstDay: provider.today, 
          lastDay: provider.today.add(Duration(days: 365)),

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Station.normalSchedule.keys.map((weekday) {
            return Column(
              children: [
                Container(
                  height: 300,
                  width: (MediaQuery.of(context).size.width*0.8) / 7,
                  color: provider.focusedDate.add(Duration(days: kWeekdayToIndex[weekday]! - provider.focusedDate.weekday + 1)).compareTo(provider.selectedDate) ==0  
                  //color: (provider.selectedDate.month == provider.displayedMonth && provider.selectedDate.year == provider.displayedYear && kWeekdayToIndex[weekday]! + 1 == provider.selectedDate.weekday)
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                  : Colors.transparent,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: getHourInterval(Station.normalSchedule[weekday]['start-hour'], Station.normalSchedule[weekday]['end-hour']),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: provider.checkDateAvailable(index, weekday)
                      ? () => provider.updateSelectedDate(index, weekday)
                      : null ,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        decoration: BoxDecoration(
                          color: (provider.focusedDate.add(Duration(days: kWeekdayToIndex[weekday]! - provider.focusedDate.weekday + 1)) == provider.selectedDate) && index == provider.selectedHour
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: provider.focusedDate.add(Duration(days: kWeekdayToIndex[weekday]! - provider.focusedDate.weekday + 1)) == provider.selectedDate 
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey
                          )
                        ),
                        child: Text(
                          formatHourToHoursAndMinutes(int.parse(Station.normalSchedule[weekday]['start-hour'].substring(0,2))  + index),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}