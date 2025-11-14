import 'package:flutter/material.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();

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
                InputTextFieldWidget(controller: _emailController),

                SizedBox(height: 50.0),

                /// Password label
                LabelWidget(
                  label: 'Password',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
