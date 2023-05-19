import 'package:product_list/domain/entities/product_table.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _dbHelper;

  DbHelper._instance() {
    _dbHelper = this;
  }

  factory DbHelper() => _dbHelper ?? DbHelper._instance();

  static Database? db;
  Future<Database?> get database async {
    if (db == null) {
      db = await _initDb();
    }

    return db;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final dbPath = '$path/product.db';

    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE product (
      id INT PRIMARY KEY,
      title TEXT,
      description TEXT,

    )
''');
  }

  Future<int> createProduct(ProductTable productTable) async {
    final db = await database;
    return await db!.insert("product", productTable.toJson());
  }
}
