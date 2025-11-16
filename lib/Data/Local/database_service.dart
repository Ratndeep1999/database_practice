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
}