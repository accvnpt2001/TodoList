import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'package:todolist/pages/home/todo_model.dart';

class DBHelper{

  static const _dbName = "mytodolist.db";
  static const _dbVersion = 1;
  static const _table1 = "Todo";
  static const columnId = "id";
  static const columnTitle = "Title";
  static const columnDescription = "Description";
  static const columnDue = "Due";
  static const columnLevel = "Level";

  //constructor singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await  _initDatabase();

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate 
    );
  }


  _onCreate(Database db, int version) async {
    await db
        .execute('''
        CREATE TABLE $_table1 (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnDescription TEXT,
        $columnDue TEXT,
        $columnLevel INTEGER)
        ''');
  }

  Future<List<TodoModel>> read() async{
    Database db = await instance.database;
    var list = await db.query(_table1, orderBy: columnId);
    List<TodoModel> todoList = list.isNotEmpty ?
      list.map((e) => TodoModel.fromJson(e)).toList() : [];
    return todoList;
  }

  Future<int> insert(TodoModel todoModel) async {
    Database db = await instance.database;
    return await db.insert(_table1, todoModel.toJson());
  }

  Future<int> delete(int? id) async {
    Database db = await instance.database;
    return await db.delete(_table1, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(TodoModel todo) async {
    Database db = await instance.database;
    return await db.update(_table1, todo.toJson(), where: '$columnId = ? ', whereArgs: [todo.id]);
  }
}