import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Models/Note_Model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  // ignore: avoid_init_to_null
  static Database? _db = null;
  DatabaseHelper._instance();
  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';
  /*
   This is how our note table will look
   id | Title | Date | Priority | Status
   0     **      **      **         0
   1     **      **      **         1
  */

  Future<Database?> get db async {
    // ignore: prefer_conditional_assignment
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    // ignore: non_constant_identifier_names
    final Directory = await getApplicationDocumentsDirectory();
    // ignore: prefer_interpolation_to_compose_strings
    String path = Directory.path + 'todo_list.db';
    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDB;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(noteTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
    final List<Note> noteList = [];
    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });
    noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));
    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this.db;
    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$colId=?',
      whereArgs: [note.id],
    );

    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await this.db;
    final int result = await db!.update(noteTable, note.toMap(),
        where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database? db = await this.db;
    final int result =
        await db!.delete(noteTable, where: '$colId=?', whereArgs: [id]);
    return result;
  }
}
