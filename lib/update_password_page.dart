import 'package:flutter/material.dart';
import 'CustomWidgets/button_widget.dart';
import 'CustomWidgets/clickable_text_widget.dart';
import 'CustomWidgets/input_text_field_widget.dart';
import 'CustomWidgets/label_widget.dart';
import 'Data/Local/database_service.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key, required this.email});

  final String email;

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  DatabaseService dbService = DatabaseService();

  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;
  late final FocusNode _confPasswordNode;
  bool _isPassVisible = false;
  bool _isBothPassSame = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
    _confPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confPasswordController.dispose();
    _confPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LabelWidget(
          label: "Update New Password",
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
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

                    /// Password label
                    LabelWidget(
                      label: 'New Password',
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
                      suffixIcon: _isPassVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      suffixTap: () =>
                          setState(() => (_isPassVisible = !_isPassVisible)),
                      obscureText: _isPassVisible,
                      hintLabel: 'Enter Your Password',
                      validation: _passwordValidation,
                      nextFocus: _confPasswordNode,
                      autoFillHints: [AutofillHints.password],
                    ),
                    SizedBox(height: 30.0),

                    /// Conform Password label
                    LabelWidget(
                      label: 'Conform New Password',
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
                      hintLabel: 'Enter Password Again',
                      validation: _confPasswordValidation,
                      focusNode: _confPasswordNode,
                    ),
                    SizedBox(height: 50.0),

                    /// Signup Button
                    ButtonWidget(
                      label: 'Change Password',
                      buttonPress: _updatePassword,
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

  /// Update Password in Database
  Future<void> _updatePassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    await dbService.updateUserPassword(
      password: _passwordController.text,
      email: widget.email,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password Updated Successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Check Password and Conf-Password same or Not
  void _onChangedConfPassword(String value) =>
      setState(() => _isBothPassSame = _passwordController.text == value);

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
