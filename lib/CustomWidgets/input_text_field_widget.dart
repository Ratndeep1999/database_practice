import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  const InputTextFieldWidget({
    super.key,
    required this.controller,
    required this.suffixIcon,
  });

  final TextEditingController controller;
  final IconData suffixIcon;
  final bool isSuffixClickable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: (email) {
        debugPrint(email);
      },
      validator: (email) {
        return null;
      },
      // autocorrect: ,
      // autofillHints: ,
      // onFieldSubmitted: ,
      // focusNode: ,
      autofocus: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hint: Text('Enter your Email id'),
        suffixIcon: isSuffixClickable
            ? IconButton(onPressed: () {}, icon: Icon(suffixIcon, size: 20))
            : Icon(suffixIcon, size: 20),
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
        isDense: true,
      ),
    );
  }
}
