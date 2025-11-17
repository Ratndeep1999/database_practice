import 'package:database_practice/CustomWidgets/circular_Indicator_widget.dart';
import 'package:database_practice/CustomWidgets/list_view_builder_widget.dart';
import 'package:database_practice/CustomWidgets/user_edit_bottom_sheet.dart';
import 'package:database_practice/Data/Local/database_service.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  /// Users List
  List<Map<String, dynamic>> usersList = [];
  late DatabaseService dbService;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelWidget(
          label: "Users List",
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
      ),
      body: SafeArea(
        child: isLoading
            ? CircularIndicatorWidget()
            : usersList.isEmpty
            ? Center(
                child: LabelWidget(
                  label: "No User Found",
                  fontSize: 30.0,
                  fontColor: Colors.orange,
                ),
              )
            : ListViewBuilderWidget(
                users: usersList,
                onEdit: _editIconPress,
                onDelete: _deleteIconPress,
              ),
      ),
    );
  }

  /// Method add that initialize database
  Future<void> _initDatabase() async {
    dbService = DatabaseService();
    await dbService.database;
  }

  /// Method to Load Users in List
  Future<void> _getUsers() async {
    final users = await dbService.getUsersList();
    usersList = users;
    // Disable Loading Indicator
    isLoading = false;
    setState(() {});
  }

  /// Edit Icon Functionality
  Future<void> _editIconPress(int id, String userName, String emailId) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (c) => UserEditBottomSheet(
        id: id,
        oldName: userName,
        oldEmail: emailId,
        onUpdateUser: _updateUserData,
      ),
    );
  }

  /// Delete Icon Functionality
  Future<void> _deleteIconPress(int id) async {
    await dbService.deleteUser(id: id);
    _getUsers();
  }

  /// Method to Update User Data
  void _updateUserData() {}
}
