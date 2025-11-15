import 'package:flutter/material.dart';

class ClickableTextWidget extends StatelessWidget {
  const ClickableTextWidget({
    super.key,
    required this.click,
    required this.label,
  });

  final VoidCallback click;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.black45,
        ),
      ),
    );
  }
}
