import 'package:flutter/material.dart';
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

  _sbmtForm(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    Map<String, String>? specialCake,
    BuildContext ctx,
  ) {
    //Set the cakeval
    setState(() {
      cake = Cake.withFlashcard(
          og: oCake,
          cc: cCake,
          mt: mCake,
          special: {specialCake?.values.first: sCake});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    final now = DateTime.now();

    final Map<String, String> date = {
      "day": DateFormat('EEEE').format(DateTime.now()).toString(),
      "month": DateFormat('MMMM').format(DateTime.now()).toString(),
      "date": now.day.toString()
    };

    return Container(
      color: Color.fromRGBO(252, 246, 241, 1),
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
                    backgroundColor: Color(0xFFFEF9E8),
                    boXTitle: "How many cakes are you making?",
                    boxWidth: screenWidth,
                    child: CakeForm(formAction: _sbmtForm)),
                const SizedBox(
                  height: 35,
                ),
                BoxContainer(
                    backgroundColor: Color(0xFFFFFFFF),
                    boXTitle: "Ingredient summary",
                    boxWidth: screenWidth,
                    child: IngredientTable(
                      cakeVal: cake,
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centers the buttons horizontally
                  children: [
                    InputButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 24,
                      ),
                      color: Color(0xFFF0C7C3),
                      title: "Reset",
                      onPressed: () => {},
                    ),
                    SizedBox(width: 10), // Add spacing between buttons
                    InputButton(
                      icon: const Icon(
                        Icons.check,
                        color: Color(0xFFFFFFFF),
                        size: 24,
                      ),
                      color: Color(0xFFE9B34F),
                      title: "Confirm",
                      onPressed: () {
                        print("presss");
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
