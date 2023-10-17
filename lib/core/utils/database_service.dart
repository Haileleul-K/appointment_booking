import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _intialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'trip.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _intialize() async {
    final path = await fullPath;
    var database =
        openDatabase(path, onCreate: create, version: 1, singleInstance: true);
    return database;
  }

  Future<void> create(Database db, int version) async =>
      await TicketDB().createTable(db);
}

class TicketDB {
  final tableName = 'Tickets';
  Future createTable(Database database) async {
    await database.execute("""    CREATE TABLE IF NOT EXIST $tableName (
  "id" INTEGER NOT NULL,
  "created_at" INTIGER,
  "updated_at" INTIGER,
  "title" INTEGER,
  PRIMARY KEY ("Id" AUTOINCREMENT)
);""");
  }

  Future<int> create({required String title}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert("""
INSERT INTO $tableName (title,created_at) VALUES (?,?)
""", [title, DateTime.now().millisecondsSinceEpoch]);
  }
}
