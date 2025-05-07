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
      padding: const EdgeInsets.all(8.0), // Add some padding for spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
        children: [
          Checkbox(
            value: isComplete, // Boolean state variable
            onChanged: (bool? value) {
              setState(() {
                isComplete = !isComplete;
              });
            },
          ),
          Expanded(
            // Ensures text wraps instead of overflowing
            child: Text(
              widget.todoTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              softWrap: true, // Allow text to wrap
              overflow: TextOverflow.visible, // Prevent text from being cut off
            ),
          ),
        ],
      ),
    );
  }
}
