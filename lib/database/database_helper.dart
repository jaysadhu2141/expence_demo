import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' ;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {


  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  static const _databaseName = 'expense_demo.db';
  static const _databaseVersion = 1;

  static const tableExpense = 'tbl_expense';


  static const colId = 'id';
  static const colTitle = 'title';
  static const colAmount = 'amount';
  static const colDate = 'date';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /* Future<Database> */
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);


    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateDB);
  }



  void _onCreateDB(Database db, int version) async {

    String sqlTableExpense = '''
    CREATE TABLE $tableExpense(
      $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $colTitle TEXT,
      $colAmount TEXT,
      $colDate TEXT
    )
    ''';

    await db.execute(sqlTableExpense);

  }



  // Method to Insert Record
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



  // Method to Delete Specific Records from Table Specified
  Future<int> delete(String tableName,
      {required String whereColumn, required int whereColumnValue}) async {
    Database db = await instance.database;
    var result = await db.delete(tableName,
        where: '$whereColumn = ?', whereArgs: [whereColumnValue]);
    return result;
  }




  // Custom Query
  Future<List<Map<String, dynamic>>> customQuery(String query) async {
    Database db = await instance.database;
    var result = await db.rawQuery(query);
    return result;
  }




}
