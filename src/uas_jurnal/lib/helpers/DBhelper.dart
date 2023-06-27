import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'journals.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE journals(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getJournals() async {
    final Database db = await database();
    return db.query('journals');
  }

  static Future<void> addJournal(String title, String body) async {
    final Database db = await database();
    await db.insert(
      'journals',
      {'title': title, 'body': body},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateJournal(int id, String title, String body) async {
    final Database db = await database();
    await db.update(
      'journals',
      {'id': id, 'title': title, 'body': body},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteJournal(int id) async {
    final Database db = await database();
    await db.delete(
      'journals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> searchJournals(
      String keyword) async {
    final Database db = await database();
    return db.query(
      'journals',
      where: 'title LIKE ? OR body LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
    );
  }
}
