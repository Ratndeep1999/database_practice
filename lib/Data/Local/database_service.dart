import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _instance = DatabaseService.internal();

  DatabaseService.internal();

  factory DatabaseService() {
    return _instance;
  }

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
      onCreate: (Database db, int version) {},
    );
    return openDB;
  }

}
