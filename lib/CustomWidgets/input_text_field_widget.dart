import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  const InputTextFieldWidget({
    super.key,
    required this.controller,
    this.suffixIcon,
    required this.isSuffixIcon,
    this.suffixTap,
    required this.obscureText,
    required this.hintLabel,
    required this.onSaved,
    this.onChange,
  });

  final TextEditingController controller;
  final IconData? suffixIcon;
  final bool isSuffixIcon;
  final VoidCallback? suffixTap;
  final bool obscureText;
  final String hintLabel;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChange,
      validator: (email) {
        return null;
      },
      // autocorrect: ,
      // autofillHints: ,
      // onFieldSubmitted: ,
      // focusNode: ,
      obscureText: obscureText,
      autofocus: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hint: Text(hintLabel),
        suffixIcon: isSuffixIcon
            ? IconButton(onPressed: suffixTap, icon: Icon(suffixIcon, size: 20))
            : null,
        isDense: true,
        // Borders
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.black26),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}
