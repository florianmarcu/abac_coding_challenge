import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_provider.dart';
import 'package:flutter/material.dart';

/// Widget for the first step of the Stepper
/// Contains a table with add or remove capabilites 
class RepairSpaceshipStepChangeParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RepairSpaceshipPageProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Task 1"),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
          ),
          //padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(/// Parts Table header
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                  child: Text(
                  "Produs", 
                  style: Theme.of(context).textTheme.bodyLarge
                ),
              ),
              Expanded(
                flex: 2,
                  child: Text(
                  "Cantitate",
                  style: Theme.of(context).textTheme.bodyLarge
                ),
              ),
              Expanded(
                flex: 2,
                  child: Text(
                  "Preț unitar",
                  style: Theme.of(context).textTheme.bodyLarge
                ),
              ),
              Expanded(
                flex: 1,
                  child: Text(
                  "Total",
                  style: Theme.of(context).textTheme.bodyLarge
                ),
              )
            ],
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: provider.selectedParts.map((part) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: Text(part.name)),
                    Expanded(flex: 2, child: Text("${part.quantity}")),
                    Expanded(flex: 2, child: Text("${part.pricePerUnit}")),
                    Expanded(flex: 1, child: SizedBox(
                      width: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(part.totalPrice.toStringAsFixed(0)), GestureDetector(
                          onTap: () => provider.removePart(part),
                          child: Icon(Icons.cancel, size: 15,)
                        )]
                      ),
                    )),
                  ],
                ),
              ),
              // Positioned(right: 0, child: GestureDetector(
              //   onTap: () => provider.removePart(part),
              //   child: Icon(Icons.cancel)
              // ))
            ],
          )).toList(),
        ),
        Form(
          key: provider.formKey,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: Icon(Icons.search),
                    labelText: "Rulmeant",
                    errorMaxLines: 2,
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: provider.validatePartName,
                  onChanged: provider.updateCurrentPartName,
                ),
              ),
              // SizedBox(width: 15,),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          //suffixIcon: Icon(Icons.add_circle_outlined,),
                          contentPadding: EdgeInsets.zero,
                          label: Text("2"),
                          errorMaxLines: 2,
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          floatingLabelBehavior: FloatingLabelBehavior.never
                        ),
                        initialValue: provider.currentPartQuantity.toString(),
                        onChanged: provider.updateCurrentPartQuantity,
                        validator: provider.validateQuantity,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => provider.addPart(context),
                      child: Icon(Icons.add_circle_outlined,),
                    )
                  ],
                ),
              ),
              Spacer(flex: 2,),
              Spacer(flex: 1,)
            ],
          ),
        )
      ],
    );
  }
}