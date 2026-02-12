import 'package:flutter/material.dart';

import '../Enums/user_sort_type.dart';

class UsersListSortingWidget extends StatelessWidget {
  const UsersListSortingWidget({super.key, required this.onSortSelected});

  final void Function(UserSortType sortType) onSortSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<UserSortType>(
      onSelected: onSortSelected,
      itemBuilder: (context) => const [
        PopupMenuItem(value: UserSortType.nameAsc, child: Text('Name ↑')),
        PopupMenuItem(value: UserSortType.nameDesc, child: Text('Name ↓')),
        PopupMenuItem(value: UserSortType.emailAsc, child: Text('Email ↑')),
        PopupMenuItem(value: UserSortType.emailDesc, child: Text('Email ↓')),
        PopupMenuItem(value: UserSortType.idAsc, child: Text('Id ↑')),
        PopupMenuItem(value: UserSortType.idDesc, child: Text('Id ↓')),
      ],
    );
  }
}
