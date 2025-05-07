import 'package:flutter/material.dart';

class BoxSummary extends StatelessWidget {
  const BoxSummary({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth / 2 - 50,
      height: 90.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(205, 124, 46, 1), // border color
          width: 2, // border width
        ),
        borderRadius: BorderRadius.circular(10), // border radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(233, 179, 79, 1),
            ),
          ),
        ],
      ),
    );
  }
}
