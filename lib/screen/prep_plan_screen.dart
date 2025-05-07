import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetsu_prep_plan_maker/model/cake/cake.dart';
import 'package:tetsu_prep_plan_maker/screen/home_screen.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_container.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/button/input_button.dart';
import 'package:tetsu_prep_plan_maker/widgets/form/form.dart';
import 'package:tetsu_prep_plan_maker/widgets/table/IngredientTable.dart';
import 'package:intl/intl.dart';

class PrepPlan extends StatefulWidget {
  const PrepPlan({super.key});

  @override
  State<PrepPlan> createState() => _PrepPlanState();
}

class _PrepPlanState extends State<PrepPlan> {
  Cake cake = Cake.defaultValues();
  int madsVal = 0;

  _sbmtForm(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    int mads,
    Map<String, String>? specialCake,
    BuildContext ctx,
  ) {
    // Set the cakeval
    setState(() {
      cake = Cake.withFlashcard(
          og: oCake,
          cc: cCake,
          mt: mCake,
          special: {specialCake?.values.first: sCake});
      madsVal = mads;
    });
  }

  final GlobalKey<CakeFormState> _cakeFormKey = GlobalKey<CakeFormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final now = DateTime.now();

    final Map<String, String> date = {
      "day": DateFormat('EEEE').format(DateTime.now()).toString(),
      "month": DateFormat('MMMM').format(DateTime.now()).toString(),
      "date": now.day.toString()
    };

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: const Color.fromRGBO(252, 246, 241, 1),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 16.0, 50.0, 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Uncle Tetsu Ottawa",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.left,
                            "${date["day"]}, ${date["month"]} ${date["date"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      BoxContainer(
                          backgroundColor: const Color(0xFFFEF9E8),
                          boXTitle: "How many are you making?",
                          boxWidth: screenWidth,
                          child: CakeForm(
                            key: _cakeFormKey,
                            formAction: _sbmtForm,
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      BoxContainer(
                          backgroundColor: const Color(0xFFFFFFFF),
                          boXTitle: "Ingredient summary",
                          boxWidth: screenWidth,
                          child: IngredientTable(
                            config: [
                              {"cake": cake},
                              {"mads": madsVal}
                            ],
                          )),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.black,
                              size: 24,
                            ),
                            isReady: true,
                            color: const Color(0xFFF0C7C3),
                            title: "Reset",
                            onPressed: () {
                              setState(() {});
                              _cakeFormKey.currentState?.resetFields();
                            },
                            dimension: const [150, 45],
                          ),
                          const SizedBox(width: 10),
                          InputButton(
                            icon: const Icon(
                              Icons.check,
                              color: Color(0xFFFFFFFF),
                              size: 24,
                            ),
                            color: const Color(0xFFE9B34F),
                            title: "Confirm",
                            isReady: true,
                            onPressed: () async {
                              // Save state and config when navigating to Home
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isOnHomeScreen', true);
                              await prefs.setString(
                                'homeConfig',
                                jsonEncode([
                                  {"cake": cake},
                                  {"mads": madsVal}
                                ]),
                              );
                              if (context.mounted) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Home(
                                      config: [
                                        {"cake": cake},
                                        {"mads": madsVal}
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            dimension: const [150, 45],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
