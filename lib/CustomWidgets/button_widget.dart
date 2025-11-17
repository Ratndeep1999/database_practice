import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.label,
    required this.buttonPress,
    this.icon,
    this.buttonWidth
  });

  final String label;
  final IconData? icon;
  final VoidCallback buttonPress;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? double.infinity,
      child: ElevatedButton.icon(
        onPressed: buttonPress,
        label: Text(label),
        icon: Icon(icon),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      ),
    );
  }
}
