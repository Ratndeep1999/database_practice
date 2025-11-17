import 'package:flutter/material.dart';
import '../Data/Local/database_service.dart';
import 'icon_widget.dart';

class ListViewBuilderWidget extends StatelessWidget {
  const ListViewBuilderWidget({
    super.key,
    required this.users,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Map<String, dynamic>> users;
  final Function(int id, String userName, String emailId) onEdit;
  final Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      itemCount: users.length,
      itemBuilder: (_, index) {
        final user = users[index];

        /// List Tile Build Method
        return _buildUserTile(index, user);
      },
    );
  }

  /// Custom ListTile Method to Build User Tile
  Widget _buildUserTile(int index, Map<String, dynamic> user) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Text("${index + 1}"),
        title: Text(user[DatabaseService.kUserName]),
        subtitle: Text(user[DatabaseService.kEmailId]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Edit Icon
            IconWidget(
              iconPress: () => onEdit(
                user[DatabaseService.kId],
                user[DatabaseService.kUserName],
                user[DatabaseService.kEmailId],
              ),
              icon: Icons.edit,
              iconSize: 20,
              iconColor: Colors.black45,
            ),
            SizedBox(width: 8.0),

            /// Delete Icon
            IconWidget(
              iconPress: () => onDelete(user[DatabaseService.kId]),
              icon: Icons.delete,
              iconSize: 20,
              iconColor: Colors.black45,
            ),
          ],
        ),

        /// Styling
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 13,
          color: Colors.black54,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: Colors.orange.shade100,
        iconColor: Colors.black45,
        titleAlignment: ListTileTitleAlignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
