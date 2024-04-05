import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transkriptor/core/errors/exceptions.dart';

import '../../models/transkript_model.dart';

abstract class LocalDatabase {
  Future<void> insert(TranskriptModel model);
  Future<List<TranskriptModel>> getAll();
  Future<void> delete(int id);
}

class LocalDatabaseImpl implements LocalDatabase {
  Database? db;
  init() async {}

  Future<void> open() async {
    final path = await _getPath();
    db = await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<String> _getPath() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Transkrpts.db');
    return path;
  }

  FutureOr<void> _createTable(Database db, int version) async {
    await db.execute('''
create table $tableName ( 
    $columnId integer primary key autoincrement, 
    $columnText text not null,
    $columnTime text not null
   )
  ''');
  }

  @override
  Future<void> insert(TranskriptModel todo) async {
    try {
      if (db == null) {
        await open();
      } else {
        await db!.insert(tableName, todo.toMap());
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<List<TranskriptModel>> getAll() async {
    List<TranskriptModel> transkripts = [];
    try {
      if (db == null) {
        await open();
      }
      List<Map<String, dynamic>> maps = await db!.query(tableName,
         
         );
         print(maps);
      if (maps.isNotEmpty) {
        for (var transkript in maps) {
          transkripts.add(TranskriptModel.fromJson(transkript));
        }
      }
      return transkripts;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      if (db == null) {
        await open();
      } else {
        await db!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
      }
  
    } catch (e) {
      throw CacheException();
    }
  }

 


}

const String tableName = 'transkripts';
const String columnId = '_id';
const String columnText = 'text';
const String columnTime = 'timeStamp';

