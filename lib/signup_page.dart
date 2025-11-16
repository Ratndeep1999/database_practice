import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:database_practice/CustomWidgets/input_text_field_widget.dart';
import 'package:database_practice/Data/Local/database_service.dart';
import 'package:database_practice/users_list.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DatabaseService dbService = DatabaseService();

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
        automaticallyImplyLeading: false,
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
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.0),

                    /// Full name label
                    LabelWidget(
                      label: 'Full Name',
                      fontColor: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.0),

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
                    SizedBox(height: 25.0),

                    /// Email label
                    LabelWidget(
                      label: 'Email Address',
                      fontColor: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.0),

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
                    SizedBox(height: 25.0),

                    /// Password label
                    LabelWidget(
                      label: 'Password',
                      fontColor: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.0),

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
                    SizedBox(height: 25.0),

                    /// Conform Password label
                    LabelWidget(
                      label: 'Conform password',
                      fontColor: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.0),

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
                    SizedBox(height: 50.0),

                    /// Signup Button
                    ButtonWidget(
                      label: 'Create Account',
                      buttonPress: _createAccount,
                      icon: Icons.account_circle,
                    ),
                    SizedBox(height: 20.0),

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
        ),
      ),
    );
  }

  /// Create Account Logic
  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _savedDetails();
      // _navigateToLoginPage();
      _saveUserDataToDB();
      _navigateToHomePage();
    }
  }

  /// Method to Check Saved Values
  void _savedDetails() {
    debugPrint('Full Name : $_name');
    debugPrint('Email : $_email');
    debugPrint('Password : $_password');
    debugPrint('Conform Password : $_confPassword');
  }

  /// Navigate To Login Screen
  void _navigateToLoginPage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please Enter Email Address';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) return "Email address must contain '@' and '.com'";
    return null;
  }

  /// Password Validation
  String? _passwordValidation(String? value) {
    String? password = value;
    if (password == null || password.isEmpty) return 'Please Enter Password';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (password.contains(' ')) return 'Space is Not Allowed';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "Must contain uppercase letter";
    if (!RegExp(r'[a-z]').hasMatch(password)) return "Must contain lowercase letter";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Must contain a number";
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password)) return "Must contain one special character (!@#\$&*~_)";
    return null;
  }

  /// Conform Password Validation
  String? _confPasswordValidation(String? confPassword) {
    if (confPassword == null || confPassword.isEmpty) return 'Please Enter Conform Password';
    if (_isPassConfPassSame == false) return 'Password And Conform Password is Not Same';
    return null;
  }

  void _saveUserDataToDB() {
    dbService.insertUser(
      emailId: _email,
      userName: _name,
      password: _password,
      conformPassword: _confPassword,
    );
  }

  /// Temporary method to Navigate to Home Page 
  void _navigateToHomePage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UsersList()));
  }
}
