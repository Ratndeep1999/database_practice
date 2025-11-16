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
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 15.0,
                  strokeAlign: 10.0,
                ),
              )
            : usersList.isEmpty
            ? Center(
                child: LabelWidget(
                  label: "No User Found",
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.orange,
                ),
              )
            : ListView.builder(
                reverse: true,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                itemCount: usersList.length,
                itemBuilder: (_, index) {
                  final user = usersList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text(user[DatabaseService.kUserName]),
                      subtitle: Text(user[DatabaseService.kEmailId]),
                      trailing: Icon(Icons.delete, size: 20.0),
                      tileColor: Colors.orange.shade100,
                      iconColor: Colors.black45,
                      titleAlignment: ListTileTitleAlignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
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
}
