import 'package:database_practice/update_password_page.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/button_widget.dart';
import 'CustomWidgets/clickable_text_widget.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';
import 'Data/Local/database_service.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final DatabaseService dbService;
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = DatabaseService();
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelWidget(
          label: "Forget Password",
          fontSize: 25,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      validation: _emailValidation,
                      keyboardType: TextInputType.emailAddress,
                      autoFillHints: [AutofillHints.email],
                      nextFocus: null,
                      focusNode: _emailFocus,
                    ),
                    SizedBox(height: 50.0),

                    /// Check Email Button
                    ButtonWidget(
                      label: "Check Email",
                      buttonPress: _checkEmail,
                      icon: Icons.search,
                    ),
                    SizedBox(height: 30.0),

                    /// Back to login
                    Center(
                      child: ClickableTextWidget(
                        click: () => Navigator.pop(context),
                        label: 'Back to login',
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

  /// Method
  Future<void> _checkEmail() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final userEmail = await dbService.checkUserEmail(
      email: _emailController.text.trim().toLowerCase(),
    );
    if (!mounted) return;

    if (userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text("Check Email Address Again.."),
        ),
      );
      return;
    }

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UpdatePasswordPage(
            email: _emailController.text.trim().toLowerCase(),
          ),
        ),
      );
    });
  }

  /// Email Validation method
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please enter Email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "Email address must contain '@' and '.com'";
    return null;
  }
}
