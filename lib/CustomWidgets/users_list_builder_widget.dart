import 'package:flutter/material.dart';
import 'icon_widget.dart';

typedef EditUserCallback =
    void Function({
      required int id,
      required String userName,
      required String emailId,
    });

typedef DeleteUserCallback = void Function({required int id});

class UsersListBuilderWidget extends StatelessWidget {
  const UsersListBuilderWidget({
    super.key,
    required this.usersList,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Map<String, dynamic>> usersList;
  final EditUserCallback onEdit;
  final DeleteUserCallback onDelete;

  static const String _idKey = 'id';
  static const String _nameKey = 'username';
  static const String _emailKey = 'email';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      padding: const EdgeInsets.all(16),
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        /// Separate users
        final Map<String, dynamic> user = usersList[index];
        return _buildUserTile(index, user);
      },
    );
  }

  Widget _buildUserTile(int index, Map<String, dynamic> user) {
    final int id = user[_idKey] as int;
    final String name = user[_nameKey] as String;
    final String email = user[_emailKey] as String;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Text(id.toString()),
        title: Text(name),
        subtitle: Text(email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconWidget(
              iconPress: () => onEdit(id: id, userName: name, emailId: email),
              icon: Icons.edit,
              iconSize: 20,
              iconColor: Colors.black45,
            ),
            const SizedBox(width: 8),
            IconWidget(
              iconPress: () => onDelete(id: id),
              icon: Icons.delete,
              iconSize: 20,
              iconColor: Colors.black45,
            ),
          ],
        ),
        tileColor: Colors.orange.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
