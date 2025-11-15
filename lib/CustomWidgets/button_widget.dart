import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.label,
    required this.buttonPress,
  });

  final String label;
  final VoidCallback buttonPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: buttonPress,
        label: Text(label),
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      ),
    );
  }
}
