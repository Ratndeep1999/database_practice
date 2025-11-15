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
          child: Form(
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
                  validation: _emailValidation,
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
                  validation: _passwordValidation,
                ),

                SizedBox(height: 50.0),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      _formKey.currentState!.validate();
                    },
                    child: Text('Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Email Validation method
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please enter Email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',).hasMatch(email)) return "Email address must contain '@' and '.com'";
    return null;
  }

  /// Password Validation method
  String? _passwordValidation(String? value) {
    String? password = value?.trim();
    if (password == null || password.isEmpty) return 'Enter your Password';
    if (password.length < 8) return "Password must be at least 8 characters";
    // at least one Uppercase char must
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "Password must contain at least one uppercase letter";
    // at least one Lowercase char must
    if (!RegExp(r'[a-z]').hasMatch(password)) return "Password must contain at least one lowercase letter";
    // at least one numeric char must
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Password must contain at least one number";
    // at least one special char must
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password)) return "Password must contain at least one special character (!@#\$&*~_)";
    return null;
  }

}
