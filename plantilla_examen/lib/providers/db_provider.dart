import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/models.dart';

class DBProvider extends ChangeNotifier {
  DBProvider();
  static Database? _database;
  static final DBProvider db = DBProvider._();
  List<Datum> listaUsuarios = [];
  DBProvider._();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
      rellenarBasedeDatos();
    }
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE Users(
  id INTEGER PRIMARY KEY,
  email TEXT,
  first_name TEXT,
  last_name TEXT,
  avatar TEXT
)
''');
    });
  }

  rellenarBasedeDatos() async {
    var base = "reqres.in";
    String endPoint = "api/users";
    var param = {"page": "1"};
    var url = Uri.https(base, endPoint, param);
    var response = await http.get(url);

    var userResponse = UsersResponse.fromJson(response.body);
    listaUsuarios = userResponse.data;

    for (int i = 0; i < userResponse.data.length; i++) {
      insertUsuario(listaUsuarios[i]);
      print("User: ${listaUsuarios[i].firstName} introducido");
    }
    notifyListeners();
  }

  Future<int> insertUsuario(Datum usuario) async {
    final id = usuario.id;
    final email = usuario.email;
    final firstName = usuario.firstName;
    final lastName = usuario.lastName;
    final avatar = usuario.avatar;

    final db = await database;
    final res = await db.rawInsert(
        "INSERT INTO Users(id,email,first_name,last_name,avatar) VALUES(?,?,?,?,?)",
        [id, email, firstName, lastName, avatar]);
    print("Resultado de si ha ido bien o no el insert ${res}");
    return res;
  }

  Future<List<Datum>> getAllUsers() async {
    final db = await database;
    final res = await db.query('Users');
    List<Datum> list =
        res.isNotEmpty ? res.map((e) => Datum.fromMap(e)).toList() : [];
    return list;
  }

  Future<Datum?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Users', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return Datum.fromMap(res.first);
    }
    return null;
  }

  Future<int> updateScan(Datum user) async {
    final db = await database;
    final res =
        db.update('Users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('''
DELETE FROM Users
''');
    return res;
  }

  Future<int> deleteById(int id) async {
    final db = await database;
    final res = await db.delete('Users', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
