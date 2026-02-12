import 'package:database_practice/CustomWidgets/circular_Indicator_widget.dart';
import 'package:database_practice/CustomWidgets/users_list_builder_widget.dart';
import 'package:database_practice/CustomWidgets/user_edit_bottom_sheet.dart';
import 'package:database_practice/Data/Local/database_service.dart';
import 'package:database_practice/signing_page.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';
import 'CustomWidgets/users_list_sorting_widget.dart';
import 'Data/Local/shared_preference_service.dart';
import 'Enums/user_sort_type.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _UsersListState();
}

class _UsersListState extends State<DashboardPage> {
  SharedPreferenceService prefs = SharedPreferenceService();
  late final DatabaseService dbService;

  /// Users List
  List<Map<String, dynamic>> usersList = [];

  /// Current Sorting
  UserSortType _currentSort = UserSortType.idDesc;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _initDatabase();
    await _loadUsers();
  }

  /// Method add that initialize database
  Future<void> _initDatabase() async {
    dbService = DatabaseService(); // Object creating in memory
    await dbService.database; // Database opens only
  }

  /// Method to Load Users in List
  Future<void> _loadUsers({UserSortType? sortType}) async {
    _currentSort = sortType ?? _currentSort;

    /// Get users from database
    final List<Map<String, dynamic>> users = await dbService.getAllUsers(
      orderBy: _currentSort.orderBy,
    );
    if (!mounted) return;

    setState(() {
      usersList = users;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: UsersListSortingWidget(
          onSortSelected: (UserSortType sortType) =>
              _loadUsers(sortType: sortType),
        ),
        title: LabelWidget(
          label: "Users List",
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
        actions: [IconButton(onPressed: _logout, icon: Icon(Icons.logout))],
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
            : UsersListBuilderWidget(
                usersList: usersList,
                onEdit: _editIconPress,
                onDelete: _deleteIconPress,
              ),
      ),
    );
  }

  /// Edit Icon Functionality
  Future<void> _editIconPress({
    required int id,
    required String userName,
    required String emailId,
  }) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UserEditBottomSheet(
        id: id,
        oldName: userName,
        oldEmail: emailId,
        onUpdateUser: () => _loadUsers(),
      ),
    );
  }

  /// Method To Delete User From Database
  Future<void> _deleteIconPress({required int id}) async {
    await dbService.deleteUser(id: id);
    _loadUsers();
  }

  Future<void> _logout() async {
    await prefs.clearAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigningPage()),
    );
  }
}
