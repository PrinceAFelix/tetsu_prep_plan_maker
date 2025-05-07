import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tetsu_prep_plan_maker/model/ingredient/Ingredients.dart';
import 'package:tetsu_prep_plan_maker/screen/prep_plan_screen.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_summary.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/box/box_todo.dart';
import 'package:tetsu_prep_plan_maker/widgets/common/button/input_button.dart';
import 'package:tetsu_prep_plan_maker/widgets/table/prep_table.dart';
import '../widgets/common/box/box_container.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.config});
  final List<Map<String, dynamic>> config;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _backgroundColor = Color.fromRGBO(252, 246, 241, 1);
  static const _boxBackgroundColor = Color.fromRGBO(249, 230, 201, 1);
  static const _dateTextColor = Color.fromRGBO(0, 0, 0, 0.5);

  List<String> _tasks = [];
  Ingredients _ingredients = Ingredients.empty();
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
      String? ingredientsJson = prefs.getString('ingredients');
      if (ingredientsJson != null) {
        _ingredients = Ingredients.fromJson(jsonDecode(ingredientsJson));
      } else {
        _ingredients = Ingredients.totalRequired(widget.config[0]["cake"]);
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
    await prefs.setString('ingredients', jsonEncode(_ingredients.toJson()));
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
      _saveData();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(screenWidth),
                  const SizedBox(height: 20),
                  _buildSummaryBox(screenWidth),
                  const SizedBox(height: 20),
                  _buildPrepPlanBox(screenWidth),
                  const SizedBox(height: 20),
                  _buildAdditionalTasksBox(),
                  const SizedBox(height: 20),
                  Center(
                    child: InputButton(
                      icon: const Icon(Icons.check,
                          color: Colors.white, size: 20),
                      color: Color.fromARGB(255, 80, 189, 76),
                      title: "Mark as Complete",
                      isReady: true,
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Confirm"),
                            content: Text(
                                "Are you sure you want to mark everything as complete?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Yes"),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          await prefs.setBool('isCompleted', true);
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => PrepPlan(),
                              ),
                            );
                          }
                        }
                      },
                      dimension: [350, 70],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    final date = _getFormattedDate();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Uncle Tetsu Ottawa",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          "${date["day"]}, ${date["month"]} ${date["date"]}",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: _dateTextColor),
        ),
      ],
    );
  }

  Widget _buildSummaryBox(double screenWidth) {
    return BoxContainer(
      backgroundColor: _boxBackgroundColor,
      boXTitle: "Summary",
      boxWidth: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxSummary(
              title: "Cream Cheese",
              value: _ingredients.getCheeseButterSummary()[0]),
          BoxSummary(
              title: "Butter", value: _ingredients.getCheeseButterSummary()[1]),
        ],
      ),
    );
  }

  Widget _buildPrepPlanBox(double screenWidth) {
    return BoxContainer(
      backgroundColor: _boxBackgroundColor,
      boXTitle: "Prep Plan",
      boxWidth: screenWidth,
      child: PrepTable(
          planIngredient:
              _ingredients.getPrepPlanSummaryList(widget.config[0]["cake"]),
          mads: widget.config[1]["mads"]),
    );
  }

  Widget _buildAdditionalTasksBox() {
    return BoxContainer(
      backgroundColor: _boxBackgroundColor,
      boXTitle: "Additional Task",
      boxWidth: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InputButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 20),
            color: Color(0xFFF2F2F2),
            title: "Add Task",
            isReady: true,
            onPressed: () => _showAddTaskDialog(),
            dimension: [150, 30],
          ),
          const SizedBox(height: 20.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return BoxTodo(todoTitle: _tasks[index]);
            },
          ),
        ],
      ),
    );
  }

  Map<String, String> _getFormattedDate() {
    final now = DateTime.now();
    return {
      "day": DateFormat('EEEE').format(now),
      "month": DateFormat('MMMM').format(now),
      "date": now.day.toString(),
    };
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: "Task Name")),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(onPressed: _addTask, child: Text("Add")),
          ],
        );
      },
    );
  }
}
