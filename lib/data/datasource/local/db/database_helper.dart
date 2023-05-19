import 'package:product_list/domain/entities/product_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _productList = 'products';
  static const String _transactions = 'transactions';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/products.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_productList (
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      price INTEGER,
      brand TEXT,
      category TEXT,
      thumbnail TEXT,
      total INTEGER
    )
''');
    await db.execute('''
    CREATE TABLE $_transactions (
      id INTEGER PRIMARY KEY,
      transaction_data TEXT
    )
''');
  }

  Future<int> insertProduct(ProductTable product) async {
    final db = await database;
    return await db!.insert(_productList, product.toJson());
  }

  Future<int> editProduct(ProductTable product) async {
    final db = await database;
    return await db!.update(_productList, product.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> deleteProduct(ProductTable product) async {
    final db = await database;
    return await db!
        .delete(_productList, where: 'id = ?', whereArgs: [product.id]);
  }

  Future<List<Map<String, dynamic>>> fetchProductCart() async {
    final db = await database;
    final results = await db!.query(_productList);

    return results;
  }
}
