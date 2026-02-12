import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  /// Singleton pattern
  DatabaseService.internal();

  static final DatabaseService _instance = DatabaseService.internal();

  factory DatabaseService() => _instance;

  /// Database object
  static Database? _database;

  /// Database config
  static const String _dbName = 'users.db';
  static const int _dbVersion = 1;

  /// Table & columns
  static const String tableUsers = 'users';
  static const String columnId = 'id';
  static const String columnUserName = 'username';
  static const String columnEmail = 'email';
  static const String columnPassword = 'password';

  /// Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUserName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL UNIQUE,
        $columnPassword TEXT NOT NULL
      )
    ''');
  }

  /// Database migrations (future use)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // handle migrations here
  }

  /// Insert user
  Future<int> insertUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    final db = await database;
    return db.insert(tableUsers, {
      columnUserName: userName,
      columnEmail: email,
      columnPassword: password,
    }, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  /// Fetch all users
  Future<List<Map<String, dynamic>>> getAllUsers({String? orderBy}) async {
    final db = await database;

    return await db.query(tableUsers, orderBy: orderBy);
  }

  /// Login user
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    final db = await database;

    final result = await db.query(
      tableUsers,
      where: '$columnEmail = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) return null;

    final user = result.first;

    if (user[columnPassword] != password) {
      return null;
    }

    return user;
  }

  /// Update user
  Future<int> updateUser({
    required int id,
    required String userName,
    required String email,
  }) async {
    final db = await database;
    return db.update(
      tableUsers,
      {columnUserName: userName, columnEmail: email},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// Delete user
  Future<int> deleteUser({required int id}) async {
    final db = await database;
    return db.delete(tableUsers, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Close database
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  /// Check user Email
  Future<Map<String, dynamic>?> checkUserEmail({required String email}) async {
    final db = await database;

    final result = await db.query(
      tableUsers,
      where: '$columnEmail = ?',
      whereArgs: [email],
      limit: 1,
    );
    final Map<String, Object?>? userEmail = result.isEmpty
        ? null
        : result.first;
    return userEmail;
  }

  /// Update User Password
  Future<int> updateUserPassword({
    required String password,
    required String email,
  }) async {
    final db = await database;
    return db.update(
      tableUsers,
      {columnPassword: password},
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
  }
}
