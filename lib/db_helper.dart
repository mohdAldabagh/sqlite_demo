import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_demo/student.dart';

class DatabaseHelper {
  static const String _databaseName = 'students.db';
  static const int _version = 1;
  static const String _table = 'Students';

  Future<Database> _intialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);

    Database stdDB = await openDatabase(
      path,
      version: _version,
      onCreate: _onCreateDB,
    );
    return stdDB;
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_table(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        mark TEXT NOT NULL  
      )
      ''');
  }

  Future<int> addStudent(Student student) async {
    final db = await _intialDB();
    return await db.insert(_table, student.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateStudent(Student student) async {
    final db = await _intialDB();
    return await db.update(_table, student.toJson(),
        where: 'id = ?',
        whereArgs: [student.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteStudent(Student student) async {
    final db = await _intialDB();
    return await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<List<Student>?> getAllStudent() async {
    final db = await _intialDB();
    final List<Map<String, dynamic>> response = await db.query(_table);
    if (response.isEmpty) {
      return null;
    }
    return List.generate(
        response.length, (index) => Student.fromJson(response[index]));
  }
}
