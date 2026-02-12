import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:database_practice/forget_password_page.dart';
import 'package:database_practice/signup_page.dart';
import 'package:database_practice/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';
import 'Data/Local/database_service.dart';
import 'Data/Local/shared_preference_service.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  SharedPreferenceService prefs = SharedPreferenceService();
  late final DatabaseService dbService;

  /// Controllers
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  /// FocusNodes
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  /// Form key
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    dbService = DatabaseService();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: 120.0),

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
                      onSaved: (email) => _email = email!.trim().toLowerCase(),
                      validation: _emailValidation,
                      keyboardType: TextInputType.emailAddress,
                      autoFillHints: [AutofillHints.email],
                      nextFocus: _passwordFocus,
                      focusNode: _emailFocus,
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
                      suffixTap: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      ),
                      obscureText: !_isPasswordVisible,
                      onSaved: (password) => _password = password,
                      validation: _passwordValidation,
                      keyboardType: TextInputType.visiblePassword,
                      autoFillHints: [AutofillHints.password],
                      focusNode: _passwordFocus,
                    ),
                    SizedBox(height: 60.0),

                    /// Login Button
                    ButtonWidget(
                      label: "Login",
                      buttonPress: _loginPress,
                      icon: Icons.login,
                    ),
                    SizedBox(height: 30.0),

                    Row(
                      children: [
                        /// SignUp Text
                        ClickableTextWidget(
                          click: _navigateToSignupPage,
                          label: 'Create Account',
                        ),
                        Spacer(),

                        /// ForgetPassword Text
                        ClickableTextWidget(
                          click: _navigateToForgetPasswordPage,
                          label: 'Forget Password',
                        ),
                      ],
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

  /// Login Button Functionality
  Future<void> _loginPress() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    /// Check is Data exist in Database
    final Map<String, dynamic>? user = await dbService.loginUser(
      email: _email!,
      password: _password!,
    );
    if (!mounted) return;

    if (user == null) {
      await _showSnackBar("Invalid email or password");
      return;
    }

    await prefs.setLoginValue(value: true);

    await _showSnackBar('Login Please Wait....');
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    });
  }

  /// Navigate to Signup Page
  void _navigateToSignupPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => SignupPage()));
  }

  /// Navigate to Forget Password Page
  void _navigateToForgetPasswordPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
  }

  /// Async Scaffold Messenger
  Future<void> _showSnackBar(String label) async {
    final controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: LabelWidget(
          label: label,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontColor: Colors.white,
        ),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 1),
      ),
    );
    await controller.closed;
  }

  /// Email Validation method
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please enter Email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "Email address must contain '@' and '.com'";
    return null;
  }

  /// Password Validation method
  String? _passwordValidation(String? value) {
    String? password = value?.trim();
    if (password == null || password.isEmpty) return 'Enter your Password';
    if (password.length < 8) return "Password must be at least 8 characters";
    // at least one Uppercase char must
    if (!RegExp(r'[A-Z]').hasMatch(password))
      return "Password must contain at least one uppercase letter";
    // at least one Lowercase char must
    if (!RegExp(r'[a-z]').hasMatch(password))
      return "Password must contain at least one lowercase letter";
    // at least one numeric char must
    if (!RegExp(r'[0-9]').hasMatch(password))
      return "Password must contain at least one number";
    // at least one special char must
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password))
      return "Password must contain at least one special character (!@#\$&*~_)";
    return null;
  }
}
