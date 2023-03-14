import 'package:abac_coding_challenge/screens/repair_spaceship/repair_spaceship_page.dart';
import 'package:abac_coding_challenge/utils/theme.dart';
import 'package:flutter/material.dart';

import 'screens/repair_spaceship/repair_spaceship_provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
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
