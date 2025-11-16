import 'package:flutter/material.dart';

import 'CustomWidgets/label_widget.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
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
          padding: EdgeInsets.symmetric(),
          itemCount: 100,
          itemBuilder: (_, index) {
            return ListTile(
              leading: Text('$index'),
              title: Text("Index : $index"),
              subtitle: Text("This is Subtitle"),
              trailing: Icon(Icons.delete, size: 20.0,),
              tileColor: Colors.orange.shade100,
              iconColor: Colors.black45,
            );
          },
        ),
      ),
    );
  }
}
