import 'package:flutter/material.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

// form key
final _formKey = GlobalKey<FormState>();
// controllers
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
// parameters
bool _isPasswordVisible = false;
String? _email;
String? _password;

class _SigningPageState extends State<SigningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: LabelWidget(
          label: "Signing Page",
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Focus(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email label
                LabelWidget(
                  label: 'Email Address',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Text field for Email
                InputTextFieldWidget(
                  hintLabel: 'Enter your Email id',
                  controller: _emailController,
                  suffixIcon: Icons.email,
                  isSuffixIcon: true,
                  obscureText: false,
                  onSaved: (email) {
                    _email = email;
                    print(_email);
                  },
                  validation: (String? value) {
                    String? email = value?.trim().toLowerCase();
                    if (email == null || email.isEmpty) return 'Please enter Email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',).hasMatch(email)) return "Email address must contain '@' and '.com'";
                    return null;
                  },
                ),
                SizedBox(height: 50.0),

                /// Password label
                LabelWidget(
                  label: 'Password',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Text field for Password
                InputTextFieldWidget(
                  hintLabel: 'Enter your Password',
                  controller: _passwordController,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  isSuffixIcon: true,
                  suffixTap: () {
                    _isPasswordVisible = !_isPasswordVisible;
                    setState(() {});
                  },
                  obscureText: !_isPasswordVisible,
                  onSaved: (password) {
                    _password = password;
                    print(_password);
                  },
                  validation: (String? value) {
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
