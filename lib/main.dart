import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_page.dart';
import 'package:abac_coding_challenge/utils/theme.dart';
import 'package:flutter/material.dart';

import 'screens/repair_spaceship/repair_spaceship_provider.dart';

void main() {
  runApp(const Main());
}


/// Starting point of the app
/// The 'home' screen is the 'RepairSpaceshipPage' which contains the Stepper
/// The project follows a 'folder-by-feature' structure, every feature of the app having its own folder for the UI and business logic
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abac Coding Challenge',
      theme: theme(context),
      home: ChangeNotifierProvider(
        create: (context) => RepairSpaceshipPageProvider(),
        child: RepairSpaceshipPage(),
      ),
    );
  }
}
