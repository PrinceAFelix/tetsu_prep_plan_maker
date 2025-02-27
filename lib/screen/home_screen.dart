import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_summary.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_todo.dart';
import 'package:tetsu_prep_plan_maker/widgets/table/prep_table.dart';

import '../widgets/common/box/box_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      backgroundColor: Color.fromRGBO(252, 246, 241, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 20),
                BoxContainer(
                  backgroundColor: Color.fromRGBO(249, 230, 201, 1),
                  boXTitle: "Summary",
                  boxWidth: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoxSummary(
                        title: "Cake Cheese",
                        value: '24 kg',
                      ),
                      BoxSummary(
                        title: "Tart Cheese",
                        value: '24 kg',
                      ),
                      BoxSummary(
                        title: "Butter",
                        value: '24 kg',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                BoxContainer(
                  backgroundColor: Color.fromRGBO(249, 230, 201, 1),
                  boXTitle: "Prep Plan",
                  boxWidth: screenWidth,
                  child: PrepTable(),
                ),
                SizedBox(height: 20),
                BoxContainer(
                  backgroundColor: Color.fromRGBO(249, 230, 201, 1),
                  boXTitle: "Additional Task",
                  boxWidth: screenWidth,
                  child: GridView.builder(
                    shrinkWrap: true, // 👈 Fixes height issue
                    physics:
                        NeverScrollableScrollPhysics(), // 👈 Prevents scrolling if not needed
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 12,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return BoxTodo(
                        todoTitle: "Todo $index",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
