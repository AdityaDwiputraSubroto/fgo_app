import 'package:fgo_app/models/login.dart';
import 'package:sqflite/sqflite.dart';
import 'dB.dart';
import 'package:bcrypt/bcrypt.dart';

class AdminService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String hashPassword(String password) {
    print("password : $password");
    print("Bcrypt password : $password");
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  Future<LoginResponse?> verifyLogin(String username, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'admin',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      final id = result.first['id'] as int;
      final storedHashedPassword = result.first['password'] as String;
      final username = result.first['username'] as String;

      if (verifyPassword(password, storedHashedPassword)) {
        return LoginResponse(id: id, username: username);
      }
    }
    var databasesPath = await getDatabasesPath();
    print(databasesPath);

    return null;
  }

  Future<bool> register(String username, String password) async {
    final db = await _dbHelper.database;
    final hashedPassword = hashPassword(password);
    final result = await db.insert(
      DatabaseHelper.adminTable,
      {'username': username, 'password': hashedPassword},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(result);
    var databasesPath = await getDatabasesPath();
    print(databasesPath);

    return result > 0;
  }

  Future<bool> updatePassword(int id, String password) async {
    final db = await _dbHelper.database;
    final hashedPassword = hashPassword(password);
    final result = await db.rawUpdate(
        'UPDATE ${DatabaseHelper.adminTable} SET password = ? WHERE id = ?',
        [hashedPassword, id]);
    print(result);
    var databasesPath = await getDatabasesPath();
    print(databasesPath);
    return result > 0;
  }

  Future<bool> updateUsername(int id, String username) async {
    final db = await _dbHelper.database;
    final result = await db.rawUpdate(
        'UPDATE ${DatabaseHelper.adminTable} SET username = ? WHERE id = ?',
        [username, id]);
    print(result);
    var databasesPath = await getDatabasesPath();
    print(databasesPath);
    return result > 0;
  }

  Future<bool> checkAdminExist() async {
    final db = await _dbHelper.database;
    final result = await db.query('admin');
    return result.isNotEmpty;
  }
}
