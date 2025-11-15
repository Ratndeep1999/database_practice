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
      body: SafeArea(child: Column(children: [
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
      ],)),
    );
  }
}
