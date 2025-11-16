import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

// Controllers
late final TextEditingController _nameController;
late final TextEditingController _emailController;
late final TextEditingController _passwordController;
late final TextEditingController _confPasswordController;

// Initialize controllers
void initControllers(){
  _nameController = TextEditingController();
  _emailController = TextEditingController();
  _passwordController = TextEditingController();
  _confPasswordController = TextEditingController();
}

// Dispose controllers
void disposeControllers(){
  _nameController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  _confPasswordController.dispose();
}

// Focus Nodes
late final FocusNode _nameNode;
late final FocusNode _emailNode;
late final FocusNode _passwordNode;
late final FocusNode _confPasswordNode;

// Initialize Nodes
void initFocusNodes(){
  _nameNode = FocusNode();
  _emailNode = FocusNode();
  _passwordNode = FocusNode();
  _confPasswordNode = FocusNode();
}

// Dispose Nodes
void disposeFocusNodes(){
  _nameNode.dispose();
  _emailNode.dispose();
  _passwordNode.dispose();
  _confPasswordNode.dispose();
}

// Variables
String? _name;
String? _email;
String? _password;
String? _confPassword;

class _SignupPageState extends State<SignupPage> {

  @override
  void initState() {
    super.initState();
    initControllers();
    initFocusNodes();
  }

  @override
  void dispose() {
    disposeControllers();
    disposeFocusNodes();
    super.dispose();
  }


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

              /// Full name label
              LabelWidget(
                label: 'Full Name',
                fontColor: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 18.0),


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
              SizedBox(height: 30.0),

              /// Back to Signing Page
              Center(
                child: ClickableTextWidget(
                  click: () => Navigator.pop(context),
                  label: 'Back to Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Create Account Logic
  void _createAccount() {}
}
