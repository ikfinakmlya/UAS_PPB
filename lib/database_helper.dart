import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
  final db = await database;
  return await db.query('books');
}


  Future<void> insertBook(String title, String author, String description) async {
    final db = await database;
    await db.insert(
      'books',
      {'title': title, 'author': author, 'description': description},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBook(int id, String title, String author, String description) async {
    final db = await database;
    await db.update(
      'books',
      {'title': title, 'author': author, 'description': description},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
