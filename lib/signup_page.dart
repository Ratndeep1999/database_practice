import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:database_practice/CustomWidgets/input_text_field_widget.dart';
import 'package:database_practice/Data/Local/database_service.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DatabaseService dbService = DatabaseService();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;

  late final FocusNode _nameNode;
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  late final FocusNode _confPasswordNode;

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isBothPassSame = false;
  String? _name;
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();

    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();

    _nameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confPasswordNode.dispose();
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
                      hintLabel: 'Enter Your Name',
                      onSaved: (name) => _name = name!.trim(),
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
                      suffixIcon: Icons.email,
                      hintLabel: 'Enter Your Email Address',
                      onSaved: (email) => _email = email!.trim().toLowerCase(),
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
                      suffixTap: () => setState(
                        () => (_isPasswordVisible = !_isPasswordVisible),
                      ),
                      obscureText: !_isPasswordVisible,
                      hintLabel: 'Enter Your Password',
                      onSaved: (password) => _password = password,
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
                      suffixIcon: _isBothPassSame
                          ? Icons.check_circle
                          : Icons.cancel,
                      suffixIconColor: _isBothPassSame
                          ? Color(0xFF93c743)
                          : Color(0xFFFF4C4C),
                      onChange: _onChangedConfPassword,
                      obscureText: false,
                      hintLabel: 'Enter Password Again',
                      validation: _confPasswordValidation,
                      focusNode: _confPasswordNode,
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
  Future<void> _createAccount() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    /// _savedDetails();
    debugPrint('Full Name : $_name');
    debugPrint('Email : $_email');
    debugPrint('Password : $_password');

    /// Save Data to Database
    await dbService.insertUser(
      userName: _name!,
      email: _email!,
      password: _password!,
    );

    if (!mounted) return;
    _showSnackBar("Account successfully created");
    Navigator.pop(context);
  }

  /// Check Password and Conf-Password same or Not
  void _onChangedConfPassword(String value) =>
      setState(() => _isBothPassSame = _passwordController.text == value);

  /// Snack Bar
  void _showSnackBar(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label, style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// UserName Validation
  String? _userNameValidation(String? value) {
    String? userName = value;
    if (userName == null || userName.isEmpty) return "Please Enter Username";
    if (userName.length < 4) return 'Name is Too Short';
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(userName))
      return 'Please Enter Letters Only';
    return null;
  }

  /// Email Validation
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please Enter Email Address';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "Email address must contain '@' and '.com'";
    return null;
  }

  /// Password Validation
  String? _passwordValidation(String? value) {
    String? password = value;
    if (password == null || password.isEmpty) return 'Please Enter Password';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (password.contains(' ')) return 'Space is Not Allowed';
    if (!RegExp(r'[A-Z]').hasMatch(password))
      return "Must contain uppercase letter";
    if (!RegExp(r'[a-z]').hasMatch(password))
      return "Must contain lowercase letter";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Must contain a number";
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password))
      return "Must contain one special character (!@#\$&*~_)";
    return null;
  }

  /// Conform Password Validation
  String? _confPasswordValidation(String? confPassword) {
    bool isBothPassSame = _passwordController.text != confPassword;
    if (_isBothPassSame == false || isBothPassSame) {
      setState(() => _isBothPassSame = false);
      return 'Password And Conform Password is Not Same';
    }
    return null;
  }
}
