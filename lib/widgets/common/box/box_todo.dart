import 'package:flutter/material.dart';

class BoxTodo extends StatefulWidget {
  const BoxTodo({super.key, required this.todoTitle});
  final String todoTitle;

  @override
  State<BoxTodo> createState() => _BoxTodoState();
}

class _BoxTodoState extends State<BoxTodo> {
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFFFCF9C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isComplete, // Boolean state variable
              onChanged: (bool? value) {
                setState(() {
                  isComplete = !isComplete;
                });
              },
            ),
            Text(
              widget.todoTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ));
  }
}
