import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

abstract class TableHelper {
  DatabaseProvider databaseProvider;
}

typedef DatabaseCreator(Database db, int version);

class DatabaseProvider {
  static DatabaseProvider _instance = DatabaseProvider._();

  Database db;
  List<DatabaseCreator> _creators;

  DatabaseProvider._() {
    _creators = List<DatabaseCreator>();
  }

  factory DatabaseProvider() {
    return _instance;
  }

  Future open() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    db = await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    _creators
        .forEach((DatabaseCreator creator) async => await creator(db, version));
  }

  void register(DatabaseCreator creator) {
    _creators.add(creator);
  }

  Future close() async => db.close();
}
