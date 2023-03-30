import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_assessment/bloc/user/user_bloc.dart';
import 'package:todo_assessment/model/task.dart';

class DatabaseHelper {
  Database? _database;

  static final _instance = DatabaseHelper._();

  DatabaseHelper._();

  factory DatabaseHelper.instance() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _configureDB();
    return _database!;
  }

  Future<Database> _configureDB() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'todo_assessment.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE ${UserState.userTable} 
        (id INTEGER PRIMARY KEY AUTOINCREMENT,
         ${UserState.usernameKey} TEXT NOT NULL,
         ${UserState.watchedShowcaseKey} BOOLEAN NOT NULL)
         ''');

        await db.execute('''
        CREATE TABLE ${Task.taskTable}
        (${Task.idKey} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Task.titleKey} TEXT NOT NULL,
        ${Task.dateKey} TEXT NOT NULL,
        ${Task.descKey} TEXT,
        ${Task.isCompletedKey} BOOLEAN NOT NULL,
        ${Task.importanceEnumKey} TEXT NOT NULL, 
        ${Task.indexKey} INTEGER NOT NULL)
        ''');
      },
    );
  }
}
