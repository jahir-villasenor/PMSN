import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica1/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/event_model.dart';

class database_helper {
  static final nombreBD = 'TECBOOKBD';
  static final versionBD = 2;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nombreBD);

    return await openDatabase(
      pathBD,
      version: versionBD,
      onCreate: _createTable,
    );
  }

  _createTable(Database db, int version) async {
    String query = '''
      CREATE TABLE tblPost (
        idPost INTEGER PRIMARY KEY,
        dscPost VARCHAR(200),
        datePost DATE
      );''';
    await db.execute(query);
    String query2 = '''
      CREATE TABLE tblEvents (
        idEvents INTEGER PRIMARY KEY,
        dscEvents VARCHAR(200),
        dateEvents DATE,
        finished INTEGER
      );
    ''';
    await db.execute(query2);
  }

  Future<int> INSERTAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion.insert(table, map);
  }

  Future<int> ACTUALIZAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion
        .update(table, map, where: 'idPost = ?', whereArgs: [map['idPost']]);
  }

  Future<int> ELIMINAR(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'idPost = ?', whereArgs: [id]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> getAllEventos() async {
    var conexion = await database;
    var result = await conexion.query('tblEvents');
    return result.map((evento) => EventModel.fromMap(evento)).toList();
  }

  Future<List<EventModel>> getEventsForDay(String fecha) async {
    var conexion = await database;
    var query = "SELECT * FROM tblEvents where dateEvents=?";
    var result = await conexion.rawQuery(query, [fecha]);
    List<EventModel> events = [];
    if (result != null && result.isNotEmpty) {
      events = result.map((event) => EventModel.fromMap(event)).toList();
    }
    return events;
  }
}
