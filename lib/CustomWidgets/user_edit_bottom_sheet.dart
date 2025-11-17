import 'package:database_practice/CustomWidgets/circular_Indicator_widget.dart';
import 'package:database_practice/CustomWidgets/input_text_field_widget.dart';
import 'package:database_practice/Data/Local/database_service.dart';
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
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;

  // Database Service Object
  DatabaseService dbService = DatabaseService();

  // Variable to show Circular indicator
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.oldName);
    _emailController = TextEditingController(text: widget.oldEmail);
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
                controller: _userNameController,
                keyboardType: TextInputType.name,
                isSuffixIcon: false,
                validation: _userNameValidation,
              ),
              SizedBox(height: 25.0),

              /// Email Address Label
              LabelWidget(
                label: 'Email Address',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.0),
              InputTextFieldWidget(
                controller: _emailController,
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
                        onPressed: isSaving ? null : _updateUserDetails,
                        child: isSaving
                            ? CircularIndicatorWidget(strokeWidth: 2)
                            : Text("Save"),
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
  Future<void> _updateUserDetails() async {
    if (_formKey.currentState!.validate()) {
      /// Database Service Class Method to Update User Data
      await dbService.updateUserData(
        id: widget.id,
        userName: _userNameController.text,
        emailId: _emailController.text,
      );

      /// method call to Update User Details in List
      widget.onUpdateUser();
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
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(userName))
      return 'Please Enter Letters Only';
    return null;
  }

  /// Method that Validate Email
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please Enter Email Address';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "Email address must contain '@' and '.com'";
    return null;
  }
}
