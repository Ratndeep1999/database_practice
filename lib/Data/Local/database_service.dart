import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _instance = DatabaseService.internal();

  DatabaseService.internal();

  factory DatabaseService() {
    return _instance;
  }

  // Parameters
  // static const String kDatabaseName = "users.db";
  // static const int kDatabaseVersion = 1;
  static const String kTableName = "users";
  static const String kId = "ID";
  static const String kUserName = "UserName";
  static const String kEmailId = "Email_Id";
  static const String kPassword = "Password";
  static const String kConformPassword = "Conform_Password";

  /// Database Object
  static Database? _database;

  /// get method to initialize Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createDB();
    return _database!;
  }

  /// Create Database
  Future<Database?> _createDB() async {
    // Get Path
    String getPath = await getDatabasesPath();
    // Database Name
    const String dbName = "users.db";
    // Get path of Database
    String path = join(getPath, dbName);

    // Method that open database
    Database openDB = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        /// Sql query that creates database table
        await db.execute('''
          CREATE TABLE $kTableName (
          $kId INTEGER PRIMARY KEY AUTOINCREMENT,
          $kUserName TEXT,
          $kEmailId TEXT UNIQUE,
          $kPassword TEXT,
          $kConformPassword TEXT
          );
          ''');
      },
    );
    return openDB;
  }

  /// Insert User
  Future<void> insertUser({
    required String? userName,
    required String? emailId,
    required String? password,
    required String? conformPassword,
  }) async {
    final Database db = await database;
    // Method that insert user
    await db.insert(kTableName, {
      kUserName: userName,
      kEmailId: emailId,
      kPassword: password,
      kConformPassword: conformPassword,
    });
  }

  /// Read/Fetch User
  Future<List<Map<String, Object?>>> getUsersList() async {
    final Database db = await database;
    return await db.query(kTableName);
  }
}
