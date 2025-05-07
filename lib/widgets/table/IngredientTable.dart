import 'package:flutter/material.dart';
import 'package:tetsu_prep_plan_maker/model/cake/cake.dart';
import 'package:tetsu_prep_plan_maker/model/ingredient/Ingredients.dart';
import 'package:tetsu_prep_plan_maker/model/ingredient/madeleine.dart';

class IngredientTable extends StatefulWidget {
  const IngredientTable({super.key, required this.config});
  final List<Map<String, dynamic>> config;

  @override
  State<IngredientTable> createState() => _IngredientTableState();
}

class _IngredientTableState extends State<IngredientTable> {
  List<String> ingredient = [
    "Cream Cheese",
    "Butter",
    "Milk",
    "Flour",
    "Sugar",
    "Egg White",
    "Egg Yolk"
  ];

  @override
  Widget build(BuildContext context) {
    Ingredients ingredients =
        Ingredients.totalRequired(widget.config[0]["cake"]);
    Madeleine madeleine = Madeleine.totalRequired(widget.config[1]["mads"]);
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: List.generate(ingredient.length + 1, (index) {
        if (index == 0) {
          return TableRow(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(239, 246, 242, 1)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Ingredient",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Required",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Available",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]);
        }
        Divider(color: Colors.black, thickness: 10);
        return TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: index == ingredient.length
                    ? BorderSide.none // No border for the last row
                    : BorderSide(
                        color:
                            const Color(0x80000000), // Semi-transparent black
                        width: 0.5, // Thin border
                      ),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  ingredient[index - 1],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    ingredients.toList(madeleine)[index - 1] == "0"
                        ? '-'
                        : ingredients.toList(madeleine)[index - 1].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(244, 180, 103, 1)),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]);
      }),
    );
  }
}
