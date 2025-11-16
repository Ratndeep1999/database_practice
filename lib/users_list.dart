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
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: 100,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Text("${index + 1}"),
                title: Text("Index : $index"),
                subtitle: Text("This is Subtitle"),
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
    setState(() {});
  }
}
