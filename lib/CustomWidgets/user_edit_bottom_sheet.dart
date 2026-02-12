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
  DatabaseService dbService = DatabaseService();

  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
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
                isSuffixIcon: true,
                validation: _userNameValidation,
                suffixIcon: Icons.verified_user,
                suffixIconColor: Colors.orange,
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
                isSuffixIcon: true,
                validation: _emailValidation,
                suffixIcon: Icons.email,
                suffixIconColor: Colors.orange,
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
                        child: isSaving
                            ? CircularIndicatorWidget(
                                strokeAlign: -3,
                                strokeWidth: 3,
                              )
                            : Text("Save"),
                      ),
                    ),
                    Spacer(),

                    /// Cancel Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
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
    if (!_formKey.currentState!.validate()) return;
    setState(() => isSaving = true);

    await dbService.updateUser(
      email: _emailController.text.trim().toLowerCase(),
      userName: _userNameController.text,
      id: widget.id,
    );

    Future.delayed(Duration(seconds: 1), () {
      setState(() => isSaving = false);

      /// Method call to Update User Details in List
      widget.onUpdateUser();
      Navigator.pop(context);
    });
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
