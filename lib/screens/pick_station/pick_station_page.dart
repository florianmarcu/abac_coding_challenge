import 'package:abac_coding_challenge/screens/pick_station/pick_station_provider.dart';
import 'package:abac_coding_challenge/utils/utils.dart';
import 'package:flutter/material.dart';

/// Second screen of the app, accessed upon completion of the stepper from the home screen
/// Alows user to view and sort by several criterias the list of available repair stations
class PickStationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PickStationPageProvider>();
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Column(
              children: [
                Text("Programarea P1", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
                Text(formatDateToDateAndHour(provider.selectedDate)),
                SizedBox(height: 20,),
                Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,1), 
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2), 
                        blurRadius: 4,
                        spreadRadius: 0.1
                      ),
                    ]
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(kGenericImageUrl)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: 130,
                          color: Theme.of(context).highlightColor,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(provider.spaceshipName, style: Theme.of(context).textTheme.bodySmall,),
                              Text(provider.spaceshipManufacturingYear.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 7),),
                              Spacer(),
                              Text("SERVISARE", style: Theme.of(context).textTheme.bodySmall,)
                            ],
                          )
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(child: Text("Ofertanți"),),
          Row(
            children: [
              Spacer(),
              SizedBox(
                width: 250, 
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    labelText: "Caută ofertant",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: Icon(Icons.search)
                  ),
                  onChanged: provider.updateSearchKeyword,
                )
              ),
              Spacer()
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sortare dupa: "),
              Row(
                children: provider.sorts.keys.map((sort) => Row(
                  children: [
                    Checkbox(
                      value: provider.sorts[sort], 
                      onChanged: (value) => provider.updateSortKey(sort, value ?? false)
                    ),
                    Text(sort)
                  ],
                )).toList(),
              ),
            ],
          ),
          SizedBox(height: 20),
          Wrap(
            runSpacing: 20,
            alignment: WrapAlignment.spaceBetween,
            children: provider.displayedStations.map((station) => Container(
              height: 100,
              width: (MediaQuery.of(context).size.width*0.9) / 3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,1), 
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2), 
                    blurRadius: 4,
                    spreadRadius: 0.1
                  ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).highlightColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(station.name, style: Theme.of(context).textTheme.bodySmall,),
                          Row(
                            children: [
                              Icon(Icons.star, size: 13,),
                              Text(station.rating.toString(), style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.alarm, size: 13,),
                              Text(station.eta.toString(), style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Cost est", style: Theme.of(context).textTheme.bodySmall,),
                              Text(station.price.toStringAsFixed(0), style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(kGenericImageUrl)
                      )
                    ),
                  )
                ],
              ),
            )).toList(),
          )
        ],
      )
    );
  }
}