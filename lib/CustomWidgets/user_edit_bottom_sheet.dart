import 'package:database_practice/CustomWidgets/input_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'label_widget.dart';

class UserEditBottomSheet extends StatefulWidget {
  const UserEditBottomSheet({
    super.key,
    required this.id,
    required this.oldName,
    required this.oldEmail,
    required this.onUpdateUser,
  });

  // Parameters
  final int id;
  final String oldName;
  final String oldEmail;
  final VoidCallback onUpdateUser;

  @override
  State<UserEditBottomSheet> createState() => _UserEditBottomSheetState();
}

class _UserEditBottomSheetState extends State<UserEditBottomSheet> {
  // Form key
  final _formKey = GlobalKey<FormState>();
  // Controllers
  late final TextEditingController userNameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.oldName);
    emailController = TextEditingController(text: widget.oldEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
      child: SizedBox(
        height: 550,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Edit User Data Label
              Center(
                child: LabelWidget(
                  label: 'Edit User Data',
                  fontSize: 20,
                  fontColor: Colors.orange,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),

              /// User Name Label
              LabelWidget(
                label: 'User Name',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.0),
              InputTextFieldWidget(
                controller: userNameController,
                keyboardType: TextInputType.name,
                isSuffixIcon: false,
                validation: _userNameValidation,
              ),
              SizedBox(height: 18.0),

              /// Email Address Label
              LabelWidget(
                label: 'Email Address',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.0),
              InputTextFieldWidget(
                controller: emailController,
                keyboardType: TextInputType.name,
                isSuffixIcon: false,
                validation: _emailValidation,
              ),
              SizedBox(height: 50.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                /// Button Section
                child: Row(
                  children: [
                    /// Save Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _updateUserDetails,
                        child: Text("Save"),
                      ),
                    ),
                    Spacer(),

                    /// Cancel Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _cancelUpdate,
                        child: Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method to Update User Details
  void _updateUserDetails() {
    if (_formKey.currentState!.validate()) {

    }
  }

  /// Method to Cancel
  void _cancelUpdate() {
    Navigator.pop(context);
  }

  /// Method that Validate Updated User Name
  String? _userNameValidation(String? value) {
    String? userName = value;
    if (userName == null || userName.isEmpty) return "Please Enter Username";
    if (userName.length < 4) return 'Name is Too Short';
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(userName)) return 'Please Enter Letters Only';
    return null;
  }

  /// Method that Validate Email
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please Enter Email Address';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) return "Email address must contain '@' and '.com'";
    return null;
  }
}
