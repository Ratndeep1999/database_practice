enum UserSortType {
  nameAsc,
  nameDesc,
  emailAsc,
  emailDesc,
  idAsc,
  idDesc,
}

extension UserSortExtension on UserSortType {
  String get orderBy {
    switch (this) {
      case UserSortType.nameAsc:
        return 'username ASC';
      case UserSortType.nameDesc:
        return 'username DESC';
      case UserSortType.emailAsc:
        return 'email ASC';
      case UserSortType.emailDesc:
        return 'email DESC';
      case UserSortType.idAsc:
        return 'id ASC';
      case UserSortType.idDesc:
        return 'id DESC';
    }
  }
}
