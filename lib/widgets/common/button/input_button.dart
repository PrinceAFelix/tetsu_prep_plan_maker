import 'dart:async';
import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function() onPressed;
  final Color color;
  final Duration debounceDuration;
  final List<double> dimension;
  final bool isReady;

  static Timer? _debounce;

  const InputButton({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.debounceDuration = const Duration(milliseconds: 500),
    required this.dimension,
    required this.isReady,
  });

  void _handlePress() {
    if (_debounce?.isActive ?? false) return;
    _debounce = Timer(debounceDuration, onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        width: dimension[0],
        height: dimension[1],
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
          onPressed: isReady ? _handlePress : () => {},
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: title == "Reset" || title == "Add Task"
                  ? Colors.black
                  : Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          iconAlignment: IconAlignment.start,
        ),
      ),
    );
  }
}
