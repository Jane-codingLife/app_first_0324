import 'package:app_first_0324/database/260623_01_book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 資料庫定義
class BookDbHelper {
  static const String _databaseName = "book_db.db";
  static const String _tableName = "books";
  static const int _databaseVersion = 1;

  // 定義唯一的物件
  static final BookDbHelper instance = BookDbHelper._internal();
  // 資料庫的物件
  static Database? _database;
  // 建構式避免使用外部格式
  BookDbHelper._internal();

  // 資料庫還沒開起就開起它
  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    // 取得資料庫路徑
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Book.columnTitle} TEXT NO NULL,
        ${Book.columnAuthor} TEXT NO NULL,
        ${Book.columnPublisher} TEXT NO NULL,
        ${Book.columnPrice} INTEGER NO NULL
      )
    ''');
  }

  Future<void> closeDatabase() async {
    final Database db = await database;
    await db.close();
    _database = null;
  }

  Future<int> insertBook(Book book) async {
    final Database db = await database;

    return db.insert(
      _tableName,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> queryBooksByTitle(String title) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      columns: [
        Book.columnTitle,
        Book.columnAuthor,
        Book.columnPublisher,
        Book.columnPrice,
      ],
      where: '${Book.columnTitle} Like ?',
      whereArgs: ['%$title%'],
    );

    return _converMapsToBooks(maps);
  }

  Future<int> deleteBookByTitle(String title) async {
    final Database db = await database;

    return db.delete(
      _tableName,
      where: '${Book.columnTitle} = ?',
      whereArgs: [title],
    );
  }

  Future<List<Book>> getAllBooks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return _converMapsToBooks(maps);
  }

  List<Book> _converMapsToBooks(List<Map<String, dynamic>> maps) {
    return maps.map((map) {
      return Book(
        title: map[Book.columnTitle] as String,
        author: map[Book.columnAuthor] as String,
        publisher: map[Book.columnPublisher] as String,
        price: map[Book.columnPrice] as int,
      );
    }).toList();
  }
}
