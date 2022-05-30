import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_sample/models/customer.dart';

class DatabaseHelper {
  static const _databaseName = 'CustomerData.db';
  static const _databaseVersion = 1;

 // make this a singleton class
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${Customer.tblCustomer}(
      ${Customer.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Customer.colFirstName} TEXT,
      ${Customer.colLastName} TEXT,
      ${Customer.colBodyTemp} TEXT)
    ''');
  }

  Future<int> insertCustomer(Customer customer) async {
    Database? db = await database;
    return await db!.insert(Customer.tblCustomer, customer.toMap());
  }

  // Fetch to get all Customer Details
  Future<Future<List<Map<String, Object?>>>?> fetchCustomers() async  {
    Database? db = await database;
    var result =
        db?.rawQuery("SELECT * FROM customers");
//    var result = await db.query(noteTable, orderBy: "$colPriority ASC");  //WORKS THE SAME CALLED HELPER FUNC
    return result;
  }
}
