import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  const InputTextFieldWidget({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    this.suffixIconColor,
    required this.isSuffixIcon,
    this.suffixTap,
    required this.obscureText,
    required this.hintLabel,
    required this.onSaved,
    this.onChange,
    this.validation,
    required this.focusNode,
    this.nextFocus,
    this.autoFillHints,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final bool isSuffixIcon;
  final VoidCallback? suffixTap;
  final bool obscureText;
  final String hintLabel;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validation;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final List<String>? autoFillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChange,
      validator: validation,
      autocorrect: true,
      enableSuggestions: true,
      autofillHints: autoFillHints,
      onFieldSubmitted: (_) {
        nextFocus != null
            ? FocusScope.of(context).requestFocus(nextFocus)
            : FocusScope.of(context).unfocus();
      },
      focusNode: focusNode,
      obscureText: obscureText,
      autofocus: false,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hint: Text(hintLabel),
        suffixIcon: isSuffixIcon
            ? IconButton(
                onPressed: suffixTap,
                icon: Icon(suffixIcon, size: 20, color: suffixIconColor),
              )
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
