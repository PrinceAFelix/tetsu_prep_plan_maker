import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer(
      {super.key,
      required this.backgroundColor,
      required this.boXTitle,
      required this.boxWidth,
       this.boxHeight,
      required this.child});
  final Color backgroundColor;
  final String boXTitle;
  final double boxWidth;
  final double? boxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 0.5, color: const Color.fromRGBO(0, 0, 0, 0.5))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              boXTitle,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            child
          ],
        ),
      ),
    );
  }
}
