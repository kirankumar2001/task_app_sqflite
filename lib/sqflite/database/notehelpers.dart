import 'package:revision/sqflite/model/notemodel.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
//import 'package:todo/models/task.dart';

class DBHelper {
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Database? db;

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint('not null db');
    } else {
      try {
        String path = await getDatabasesPath() + 'task.db';
        db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' title STRING, '
              ' note TEXT, '
              ' date STRING, '
              ' startTime STRING, '
              ' endTime STRING, '
              ' remind STRING,'
              ' repeat STRING, '
              ' color INTEGER,'
              ' isCompleted INTEGER)',
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    return await db!.insert(_tableName, task!.tojson());
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query function called');
    return await db!.query(_tableName);
  }

  static Future<int> delete(Task? task) async {
    print('delete function called');
    return await db!.delete(_tableName, where: 'id = ?', whereArgs: [task!.id]);
  }

  static Future isCompleted(int id) async {
    print('Task completed');
    return await db!.rawDelete('''
    UPDATE $_tableName
    SET isCompleted = ?
    WHERE  id = ?
    ''', [1, id]);
  }
}
// '''
//           UPDATE $_tableName 
//           SET isCompleted = ?
//           id = ?
//     '''