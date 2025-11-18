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
}
