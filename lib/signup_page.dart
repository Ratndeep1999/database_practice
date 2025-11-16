import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:database_practice/CustomWidgets/input_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;

  // Initialize controllers
  void initControllers() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
  }

  // Dispose controllers
  void disposeControllers() {
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
  void initFocusNodes() {
    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confPasswordNode = FocusNode();
  }

  // Dispose Nodes
  void disposeFocusNodes() {
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
  bool _isPasswordVisible = true;
  bool _isPassConfPassSame = false;

  // FormKey
  final _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        child: SafeArea(
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

                /// Full name Text Field
                InputTextFieldWidget(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  isSuffixIcon: true,
                  obscureText: false,
                  hintLabel: 'Enter Your Name',
                  onSaved: (name) {
                    _name = name;
                  },
                  validation: _userNameValidation,
                  focusNode: _nameNode,
                  nextFocus: _emailNode,
                  autoFillHints: [AutofillHints.name],
                  suffixIcon: Icons.verified_user,
                ),

                /// Email label
                LabelWidget(
                  label: 'Email Address',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Email Address Text Field
                InputTextFieldWidget(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isSuffixIcon: true,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: Icons.email,
                  hintLabel: 'Enter Your Email Address',
                  onSaved: (email) {
                    _email = email;
                  },
                  validation: _emailValidation,
                  focusNode: _emailNode,
                  nextFocus: _passwordNode,
                  autoFillHints: [AutofillHints.email],
                ),

                /// Password label
                LabelWidget(
                  label: 'Password',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Password Text Field
                InputTextFieldWidget(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  isSuffixIcon: true,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  suffixTap: () => setState(() {
                    (_isPasswordVisible = !_isPasswordVisible);
                  }),
                  obscureText: !_isPasswordVisible,
                  hintLabel: 'Enter Your Password',
                  onSaved: (password) {
                    _password = password;
                  },
                  validation: _passwordValidation,
                  focusNode: _passwordNode,
                  nextFocus: _confPasswordNode,
                  autoFillHints: [AutofillHints.password],
                ),

                /// Conform Password label
                LabelWidget(
                  label: 'Conform password',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Conform Password Text Field
                InputTextFieldWidget(
                  controller: _confPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  isSuffixIcon: true,
                  suffixIcon: _isPassConfPassSame
                      ? Icons.check_circle
                      : Icons.cancel,
                  suffixIconColor: _isPassConfPassSame
                      ? Color(0xFF93c743)
                      : Color(0xFFFF4C4C),
                  onChange: _onChangedConfPassword,
                  obscureText: false,
                  hintLabel: 'Enter Password Again',
                  onSaved: (confPassword) {
                    _confPassword = confPassword;
                  },
                  validation: _confPasswordValidation,
                  focusNode: _confPasswordNode,
                  nextFocus: null,
                ),

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
      ),
    );
  }

  /// Create Account Logic
  void _createAccount() {}

  /// Check Password and Conf-Password same or Not
  void _onChangedConfPassword(String confPassword) {
    setState(() {
      _isPassConfPassSame = (_passwordController.text == confPassword)
          ? true
          : false;
    });
  }

  /// UserName Validation
  String? _userNameValidation(String? value) {
    String? userName = value;
    if (userName == null || userName.isEmpty) return "Please Enter Username";
    if (userName.length < 4) return 'Name is Too Short';
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(userName)) return 'Please Enter Letters Only';
    return null;
  }

  /// Email Validation
  String? _emailValidation(String? value) {
    return null;
  }

  /// Password Validation
  String? _passwordValidation(String? value) {
    return null;
  }

  /// Conform Password Validation
  String? _confPasswordValidation(String? confPassword) {
    if (_isPassConfPassSame == false) return 'Password And Conform Password is Not Same';
    return null;
  }
}
