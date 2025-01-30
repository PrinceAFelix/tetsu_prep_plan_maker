import 'package:flutter/material.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_container.dart';
import 'package:tetsu_prep_plan_maker/widgets/form/form.dart';
import 'package:tetsu_prep_plan_maker/widgets/table/ingredient/IngredientTable.dart';

class PrepPlan extends StatefulWidget {
  const PrepPlan({super.key});

  @override
  State<PrepPlan> createState() => _PrepPlanState();
}

class _PrepPlanState extends State<PrepPlan> {
  _sbmtForm(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    BuildContext ctx,
  ) {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color.fromRGBO(252, 246, 241, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 16.0, 50.0, 16.0),
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
                    "Tuesday, March 4, 2025",
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
                  boxWdith: screenWidth,
                  boxHeight: 200.0,
                  child: CakeForm(formAction: _sbmtForm)),
              const SizedBox(
                height: 35,
              ),
              BoxContainer(
                  backgroundColor: Color(0xFFFFFFFF),
                  boXTitle: "Ingredient summary",
                  boxWdith: screenWidth,
                  boxHeight: 300.0,
                  child: IngredientTable()),
            ],
          ),
        ),
      ),
    );
  }
}
