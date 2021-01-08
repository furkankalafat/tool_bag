import 'dart:async';
import 'dart:io';

import 'package:my_tool_bag/Models/HESCode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';

class DbServices {
  DbServices._();
  static final DbServices instance = DbServices._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "HesCode.db");

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE HesCode(
      ${HESCode.hesCodeName} TEXT NOT NULL, 
      ${HESCode.hesCodeId} INTEGER PRIMARY KEY 
    )
      ''');
  }

  Future<int> insertHESCode(HESCode hesCode) async {
    Database db = await database;
    return await db.insert("HesCode.db", hesCode.toMap());
  }

  Future<List<HESCode>> fetchHESCode() async {
    Database db = await database;
    List<Map> hesCodes = await db.query("Hescode.db");
    return hesCodes.length == 0
        ? []
        : hesCodes.map((e) => HESCode.fromMap(e)).toList();
  }
}
