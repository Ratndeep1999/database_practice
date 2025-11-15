import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelWidget(
          label: "Signup Page",
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

              /// Password label
              LabelWidget(
                label: 'Password',
                fontColor: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 18.0),

              /// Email label
              LabelWidget(
                label: 'Conform password',
                fontColor: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 18.0),

              /// Signup Button
              ButtonWidget(
                label: 'Create Account',
                buttonPress: _createAccount,
                icon: Icons.account_circle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Create Account Logic
  void _createAccount() {
  }
}
