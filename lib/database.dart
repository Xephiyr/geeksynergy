import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = "user.db";
  static final _dbVersion = 2;
  static final columnName = 'name';
  static final columnPass = 'password';
  static final columnEmail = 'email';
  static final columnProf = 'profession';
  static final columnNum = 'phone';
  static final tableName = 'users';
  static final List<String> values = [columnEmail, columnPass];
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return openDatabase(path, version: _dbVersion + 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('execute');
    await db.execute('''
        CREATE TABLE ${DatabaseHelper.tableName}(
        ${DatabaseHelper.columnName} TEXT,
        ${DatabaseHelper.columnPass} TEXT,
        ${DatabaseHelper.columnEmail} TEXT UNIQUE NOT NULL,
        ${DatabaseHelper.columnNum} TEXT PRIMARY KEY,
        ${DatabaseHelper.columnProf} TEXT
        )
    ''');
  }

  Future<int> insertInto(Map<String, dynamic> row) async {
    Database db = await instance.database;

    var c = await db.insert(
      DatabaseHelper.tableName,
      row,
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return c;
  }

  Future<int> queryUser(String email, String password) async {
    Database db = await instance.database;
    print('DB ready for query');
    List<Map> result = await db.query(DatabaseHelper.tableName,
        columns: values,
        where:
            '${DatabaseHelper.columnEmail} = ? and ${DatabaseHelper.columnPass} = ?',
        whereArgs: [email, password]);
    print('Query done');
    if (result.isNotEmpty) {
      return 1;
    } else
      return 0;
  }
}
