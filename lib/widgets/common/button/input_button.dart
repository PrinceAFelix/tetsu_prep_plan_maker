import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function() onPressed;
  final Color color;

  const InputButton(
      {super.key,
      required this.color,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        width: 150, // Set custom width
        height: 45, // Set custom height
        child: FilledButton.icon(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return color.withValues(alpha: 0.5);
                }
                return color;
              },
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: onPressed,
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: title == "Reset" ? Colors.black : Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          iconAlignment: IconAlignment.start,
        ),
      ),
    );
  }
}
