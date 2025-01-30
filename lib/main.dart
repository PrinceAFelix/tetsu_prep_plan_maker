import 'package:flutter/material.dart';
import 'package:tetsu_prep_plan_maker/screen/prep_plan_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainNavigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      navigatorKey: mainNavigatorKey,
      home: Scaffold(
        body: PrepPlan(),
      ),
    );
  }
}
