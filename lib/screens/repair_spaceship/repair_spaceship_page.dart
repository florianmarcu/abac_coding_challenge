import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_provider.dart';
import 'package:flutter/material.dart';

class RepairSpaceshipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RepairSpaceshipPageProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("LICITEAZĂ", style: Theme.of(context).textTheme.headlineSmall,),
            ),
            Expanded(
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                steps: provider.steps,
                currentStep: provider.currentStep,
                onStepContinue: provider.incrementCurrentStep,
                onStepTapped: provider.updateCurrentStep,
                controlsBuilder: provider.controlsBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}