import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:practica1/models/post_model.dart';
import 'package:practica1/models/event_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica1/models/popular_model.dart';

class DatabaseHelper {
  static final nameDB = 'TECKBOOK';
  static final versionDB = 4;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
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
    String query3 = '''
      CREATE TABLE tblPopularFav (
        backdrop_path TEXT,
        id INTEGER,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        vote_average REAL,
        vote_count INTEGER
      );
    ''';
    await db.execute(query3);
  }

  Future<int> INSERTAR(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return await conexion.insert(tblName, data);
  }

  Future<int> ACTUALIZAR(
      String tblName, Map<String, dynamic> data, String idColumnName) async {
    var conexion = await database;
    return await conexion.update(
      tblName,
      data,
      where: '$idColumnName = ?',
      whereArgs: [data[idColumnName]],
    );
  }

  Future<int> ELIMINAR(String tblName, int id, String idColumnName) async {
    var conexion = await database;
    return await conexion.delete(
      tblName,
      where: '$idColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventModel>> getAllEventos() async {
    var conexion = await database;
    var result = await conexion.query('tblEvents');
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  Future<List<PopularModel>> getAllPopular() async {
    var conexion = await database;
    var result = await conexion.query('tblPopularFav');
    return result.map((popular) => PopularModel.fromMap(popular)).toList();
  }

  Future<bool> searchPopular(int id_popular) async {
    var conexion = await database;
    var query = "SELECT * FROM tblPopularFav where id=?";
    var result = await conexion.rawQuery(query, [id_popular]);
    if (result != null && result.isNotEmpty) {
      return true;
    }
    return false;
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
