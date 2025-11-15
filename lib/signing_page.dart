import 'package:database_practice/CustomWidgets/button_widget.dart';
import 'package:database_practice/CustomWidgets/clickable_text_widget.dart';
import 'package:database_practice/signup_page.dart';
import 'package:database_practice/users_list.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

// Form key
final _formKey = GlobalKey<FormState>();
// Controllers
late final TextEditingController _emailController ;
late final TextEditingController _passwordController;
// Focus nodes
late final FocusNode _emailFocus;
late final FocusNode _passwordFocus;
// Parameters
bool _isPasswordVisible = false;
String? _email;
String? _password;

class _SigningPageState extends State<SigningPage> {

  @override
  void initState() {
    super.initState();
    _initController();
    _initFocusNodes();
  }

  @override
  void dispose() {
    _disposeController();
    _disposeFocusNodes();
    super.dispose();
  }

  // Method to initialize Controller
  void _initController(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  // Method to dispose Controller
  void _disposeController(){
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Method to initialize FocusNodes
  void _initFocusNodes(){
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  // Method to dispose FocusNodes
  void _disposeFocusNodes(){
    _emailController.dispose();
    _passwordController.dispose();
  }

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                    onSaved: (email) {
                      _email = email;
                    },
                    validation: _emailValidation,
                    keyboardType: TextInputType.emailAddress,
                    autoFillHints: [AutofillHints.email],
                    nextFocus: null,
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
                    suffixTap: () {
                      _isPasswordVisible = !_isPasswordVisible;
                      setState(() {});
                    },
                    obscureText: !_isPasswordVisible,
                    onSaved: (password) {
                      _password = password;
                    },
                    validation: _passwordValidation,
                    keyboardType: TextInputType.visiblePassword,
                    autoFillHints: [AutofillHints.password],
                    focusNode: _passwordFocus,
                    nextFocus: null,
                  ),
                  SizedBox(height: 60.0),

                  /// Login Button
                  ButtonWidget(label: "Login", buttonPress: _loginPress, icon: Icons.login,),
                  SizedBox(height: 30.0),

                  Row(
                    children: [
                      /// SignUp Text
                      ClickableTextWidget(click: _navigateToForgetPasswordPage, label: 'Create Account'),
                      Spacer(),
                      /// SignUp Text
                      ClickableTextWidget(click: _navigateToSignupPage, label: 'Forget Password'),
                    ],
                  ),
                ],
              ),
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
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) return "Email address must contain '@' and '.com'";
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

  /// Login Button Functionality
  Future<void> _loginPress() async {
    FocusScope.of(context).unfocus();
    // form validation check
    if (_formKey.currentState!.validate()) {
      // called onSave method of each text field
      _formKey.currentState!.save();
      // shoe snack bar for 3 sec
      await _showSnackBar('Login Please Wait....');
      // navigate to next page
      _navigateToNextPage();
    }
  }

  /// Scaffold Messenger
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
        duration: Duration(seconds: 3),
      ),
    );
    await controller.closed;
  }

  /// Navigate to UsersList page
  void _navigateToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context)=> UsersList(),
      ),
    );
  }

  /// Navigate to Signup Page
  void _navigateToSignupPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignupPage()));
  }

  /// Navigate to Forget Password Page
  void _navigateToForgetPasswordPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignupPage()));
  }
}
