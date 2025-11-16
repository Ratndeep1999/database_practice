import 'package:sqflite/sqflite.dart';

class DatabaseService {

  // Singleton pattern
  static final DatabaseService _instance = DatabaseService.internal();
  DatabaseService.internal();
  factory DatabaseService (){
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

  Future<Database?> _createDB() async {}
}