import 'dart:io';

import 'package:my_tool_bag/Models/Task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbServicesTask {
  static const _dbName = "Task.db";
  static const _dbVersion = 1;

  DbServicesTask._();
  static final DbServicesTask instance = DbServicesTask._();

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
    CREATE TABLE Task(
        id INTEGER PRIMARY KEY,
        title TEXT,
        priority TEXT,
        status INTEGER
    )
      """);
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(Task.tblTask);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((map) {
      taskList.add(Task.fromMap(map));
    });
    return taskList;
  }

  insertTask(Task task) async {
    Database db = await database;
    return await db.insert(Task.tblTask, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    Database db = await database;
    return await db.update(
      Task.tblTask,
      task.toMap(),
      where: '${Task.colId} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      Task.tblTask,
      where: '${Task.colId} = ?',
      whereArgs: [id],
    );
  }
}
