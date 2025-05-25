import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const boolType = "INTEGER NOT NULL";

    await db.execute('''
      CREATE TABLE user (
        id $idType,
        username $textType,
        email $textType,
        password $textType,
        phone $textType,
        role $textType,
        urls $textType,
        emailNotifications $boolType
      );
    ''');
  }

  Future<User> createUser(User user) async {
    final db = await instance.database;
    final id = await db.insert("user", user.toMap());
    return user.copyWith(id: id);
  }

  Future<User?> readUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'user',
      columns: ['id', 'username', 'email', 'password', 'phone', 'role', 'urls', 'emailNotifications'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}