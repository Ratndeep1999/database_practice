import 'package:database_practice/Data/Local/database_service.dart';

class UserModel {
  // Parameters
  final int? id;
  final String userName;
  final String emailId;
  final String password;
  final String confPassword;

  // Constructor
  UserModel({
    this.id,
    required this.userName,
    required this.emailId,
    required this.password,
    required this.confPassword,
  });

  /// toMap Method to return Object to Map (Insertions)
  Map<String, dynamic> toMap() {
    return {
      DatabaseService.kId: id,
      DatabaseService.kUserName: userName,
      DatabaseService.kEmailId: emailId,
      DatabaseService.kPassword: password,
      DatabaseService.kConformPassword: confPassword,
    };
  }

  /// fromMap Method to return Map to Object (Fetching)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DatabaseService.kId],
      userName: map[DatabaseService.kUserName],
      emailId: map[DatabaseService.kEmailId],
      password: map[DatabaseService.kPassword],
      confPassword: map[DatabaseService.kConformPassword],
    );
  }
}
