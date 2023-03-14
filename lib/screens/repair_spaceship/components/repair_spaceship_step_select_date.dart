import 'package:abac_coding_challenge/models/models.dart';
import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_provider.dart';
import 'package:abac_coding_challenge/utils/constants.dart';
import 'package:abac_coding_challenge/utils/format.dart';
import 'package:flutter/material.dart';

class RepairSpaceshipStepSelectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RepairSpaceshipPageProvider>();
    return Column(
      children: [
        // SfCalendar(
        //   view: CalendarView.week,
        //   monthCellBuilder: (context, details) => Center(child: Text(kMonths[details.date.month]),),
        // ),
        // CalendarWeek(
          
        //   marginDayOfWeek: EdgeInsets.zero,
        //   todayBackgroundColor: Colors.green.withOpacity(0.2),
        //   minDate: provider.today,
        //   maxDate: provider.today.add(Duration(days: 365)),

        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Station.normalSchedule.keys.map((weekday) {
            return Column(
              children: [
                Container(
                  height: 300,
                  width: 40,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: getHourInterval(Station.normalSchedule[weekday]['start-hour'], Station.normalSchedule[weekday]['end-hour']),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: (provider.today.month == provider.displayedMonth && provider.today.year == provider.displayedYear && kWeekdayToIndex[weekday] == provider.today.weekday)
                          ? Colors.green
                          : Colors.grey
                        )
                      ),
                      child: Text(
                        Station.normalSchedule[weekday]['start-hour']
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
    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(child: Container(),),
    //         Expanded(child: Text("${kMonths[provider.displayedMonth]} ${provider.displayedYear}")),
    //         Expanded(child: Row(children: [
    //           GestureDetector(
    //             onTap: provider.displayedMonth == provider.today.month
    //             ? null
    //             : () => provider.updateDisplayedMonthAndYear(provider.displayedMonth - 1),
    //             child: Container(
    //               padding: EdgeInsets.only(left: 10),
    //               decoration: BoxDecoration(
    //                 border: Border.all(width: 1,color: provider.displayedMonth == provider.today.month ? Colors.grey : Colors.black,)
    //               ),
    //               child: Icon(
    //                 Icons.arrow_back_ios,
    //                 color: provider.displayedMonth == provider.today.month ? Colors.grey : Colors.black,
    //               ),
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () => provider.updateDisplayedMonthAndYear(provider.displayedMonth + 1),
    //             child: Container(
    //               padding: EdgeInsets.symmetric(horizontal: 5),
    //               decoration: BoxDecoration(
    //                 border: Border.all(width: 1)
    //               ),
    //               child: Icon(Icons.arrow_forward_ios),
    //             ),
    //           )
    //         ],),),
    //       ],
    //     ),
    //     SizedBox(height: 10,),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: Station.normalSchedule.keys.map((weekday) {
    //         return Column(
    //           children: [
    //             Text(formatWeekdayToShortWeekday(weekday)),
    //             Container(
    //               height: 300,
    //               width: 40,
    //               child: ListView.separated(
    //                 shrinkWrap: true,
    //                 itemCount: getHourInterval(Station.normalSchedule[weekday]['start-hour'], Station.normalSchedule[weekday]['end-hour']),
    //                 separatorBuilder: (context, index) => SizedBox(height: 10),
    //                 itemBuilder: (context, index) => Container(
    //                   decoration: BoxDecoration(
    //                     border: Border.all(
    //                       width: 1,
    //                       color: (provider.today.month == provider.displayedMonth && provider.today.year == provider.displayedYear && kWeekdayToIndex[weekday] == provider.today.weekday)
    //                       ? Colors.green
    //                       : Colors.grey
    //                     )
    //                   ),
    //                   child: Text(
    //                     Station.normalSchedule[weekday]['start-hour']
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         );
    //       }).toList(),
    //     ),
    //   ],
    // );
  }
}