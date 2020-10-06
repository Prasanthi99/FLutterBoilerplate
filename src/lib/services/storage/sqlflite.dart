import 'dart:async';
import 'dart:io';

import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/services/storage/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SQLiteDB {
  // make this a singleton class
  SQLiteDB._privateConstructor();
  static final SQLiteDB instance = SQLiteDB._privateConstructor();
  static JsonRepo repo;

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    repo = repo ?? ServiceLocator.getInstance<JsonRepo>();
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = Path.join(documentsDirectory.path, DbConstants.dbName);
    var db = await openDatabase(path,
        version: DbConstants.versionNumber, onCreate: _onCreate);
    db.execute("PRAGMA foreign_keys = ON");
    return db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    try {
      await db.execute(UserDB.tableCreationQuery);
    } catch (exception) {}
  }

  Future<int> insert<T>(String tableName, T data) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      return await db.insert(tableName, repo.to(data));
      // });
    } catch (exception) {
      return null;
    } finally {
      // db.close();
    }
  }

  Future<T> getSingle<T>(String tableName, List<String> columns,
      String whereColumn, int id) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      List<Map> maps = await db.query(tableName,
          columns: columns, where: '$whereColumn = ?', whereArgs: [id]);
      if (maps.length > 0) {
        return repo.from<T>(maps.first);
      }
      // });
    } catch (exception) {
      return null;
    } finally {
      // db.close();
    }
  }

  Future<List<T>> getAll<T>(String tableName, List<String> columns,
      {String where, List<dynamic> whereArgs}) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      List<Map> maps = await db.query(tableName,
          columns: columns, where: where, whereArgs: whereArgs);
      if (maps != null && maps.length > 0) {
        List<T> modeledData = new List<T>();
        maps.forEach((eachRow) {
          modeledData.add(repo.from<T>(eachRow));
        });
        return modeledData;
      }
      // });
    } catch (exception) {
      return null;
    } finally {
      // db.close();
    }
  }

  Future<int> delete<T>(
      String tableName, String whereColumn, List<dynamic> whereArgs) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      return await db.delete(tableName,
          where: whereColumn, whereArgs: whereArgs);
      // });
    } catch (exception) {
      return 0;
    } finally {
      // db.close();
    }
  }

  Future<int> update<T>(String tableName, String whereColumn,
      List<dynamic> whereArgs, T data) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      return await db.update(tableName, repo.to(data),
          where: whereColumn, whereArgs: whereArgs);
      // });
    } catch (exception) {
      return 0;
    } finally {
      // db.close();
    }
  }

  Future<int> clearAll() async {
    Database db = await this.database;
    try {
      var count = 0;
      count += await db.delete(UserDB.tableName);
      return count;
    } catch (exception) {
      return 0;
    } finally {
      // db.close();
    }
  }

  Future<int> executeQuery(String query) async {
    Database db = await this.database;
    try {
      // await db.transaction((txn) async {
      var result = await db.rawQuery(query);
      var data = Sqflite.firstIntValue(result);
      return data;
      // });
    } catch (exception) {
      return 0;
    } finally {
      // db.close();
    }
  }
}
