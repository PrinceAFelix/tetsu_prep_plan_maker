import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetsu_prep_plan_maker/model/cake/cake.dart';
import 'package:tetsu_prep_plan_maker/screen/prep_plan_screen.dart';
import 'package:tetsu_prep_plan_maker/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainNavigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: mainNavigatorKey,
      home: FutureBuilder<Map<String, dynamic>>(
        future: _checkIfHomeScreenShouldBeShown(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.data!['isOnHomeScreen'] == true) {
            // Navigate to Home if the state is saved 
            final config = snapshot.data!['config'];
            return Home(config: config);
          } else {
            // Navigate to PrepPlan if no state is saved
            return PrepPlan();
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _checkIfHomeScreenShouldBeShown() async {
    final prefs = await SharedPreferences.getInstance();
    bool isOnHomeScreen = prefs.getBool('isOnHomeScreen') ?? false;

    if (isOnHomeScreen) {
      String? homeConfigJson = prefs.getString('homeConfig');
      if (homeConfigJson != null) {
        List<dynamic> homeConfig = jsonDecode(homeConfigJson);
        Cake cake = Cake.fromJson(homeConfig[0]["cake"]); // Deserialize Cake
        int madsVal = homeConfig[1]["mads"];
        return {
          'isOnHomeScreen': true,
          'config': [
            {"cake": cake},
            {"mads": madsVal}
          ],
        };
      }
    }

    return {'isOnHomeScreen': false};
  }
}
