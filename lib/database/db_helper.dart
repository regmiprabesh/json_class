import 'package:json_class/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;
  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('notess.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';
    await db.execute(
        '''CREATE TABLE notes (_id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL,time TEXT NOT NULL)''');
    // await db.execute('''
    //   CREATE TABLE $tableNotes (
    //     ${NotesFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    //     ${NotesFields.title} $textType,
    //     ${NotesFields.description} $textType,
    //     ${NotesFields.time} $textType,
    //      )
    //      ''');
  }

  Future<int> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    // Note n = note.copy(id: id);
    return id;
  }

  Future<List<Note>> showNotes() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);
    return result.map((e) => Note.fromJson(e)).toList();
  }
}
