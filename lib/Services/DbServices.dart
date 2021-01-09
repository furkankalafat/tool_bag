import 'dart:async';
import 'dart:io';

import 'package:my_tool_bag/Models/HESCode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';

class DbServices {
  static const _dbName = "HesCode.db";
  static const _dbVersion = 1;

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
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute("""  
    CREATE TABLE HesCode(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        hescode TEXT NOT NULL
    )
      """);
  }

  Future<int> insertHESCode(HESCode hesCode) async {
    Database db = await database;
    return db.insert(HESCode.tblHesCode, hesCode.toMap());
  }

  Future<int> updateHESCode(HESCode hesCode) async {
    Database db = await database;
    return await db.update(HESCode.tblHesCode, hesCode.toMap(),
        where: '${HESCode.colid} = ?', whereArgs: [hesCode.id]);
  }

  Future<int> deleteHESCode(int id) async {
    Database db = await database;
    return await db.delete(HESCode.tblHesCode,
        where: '${HESCode.colid} = ?', whereArgs: [id]);
  }

  Future<List<HESCode>> fetchHESCode() async {
    Database db = await database;
    List<Map> hesCodes = await db.query(HESCode.tblHesCode);
    return hesCodes.length == 0
        ? []
        : hesCodes.map((e) => HESCode.fromMap(e)).toList();
  }
}
