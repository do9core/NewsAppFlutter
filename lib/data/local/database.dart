import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/models.dart';

const FavouriteTable = 'favourites';

final Future<Database> database = openDatabase(
  'doggie_database.db',
  onCreate: (db, version) {
    return db.execute('''
      CREATE TABLE $FavouriteTable(
        url TEXT PRIMARY KEY,
        title TEXT,
        description TEXT
      )
      ''');
  },
  version: 1,
);

extension PersistenceEx on Article {
  Future<void> insert() async {
    final db = await database;
    await db.insert(
      FavouriteTable,
      {
        'url': this.url,
        'title': this.title,
        'description': this.description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete() async {
    final db = await database;
    await db.delete(
      FavouriteTable,
      where: 'url = ?',
      whereArgs: [this.url],
    );
  }
}

Future<List<Article>> favourites() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(FavouriteTable);
  return List.generate(maps.length, (i) {
    return Article(
      maps[i]['title'],
      maps[i]['description'],
      maps[i]['url']
    );
  });
}
