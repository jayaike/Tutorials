import 'package:sqflite/sqflite.dart';
import 'package:sqldatabase/database/database_helper.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class Todo {
  int id;
  String title;
  bool done;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }
}

class TodoHelper implements TableHelper {
  static TodoHelper _instance = TodoHelper._();

  DatabaseProvider databaseProvider;

  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
          create table $tableTodo ( 
            $columnId integer primary key autoincrement, 
            $columnTitle text not null,
            $columnDone integer not null)
        ''');
  }

  TodoHelper._() {
    databaseProvider = DatabaseProvider();
  }

  factory TodoHelper() {
    return _instance;
  }
}
