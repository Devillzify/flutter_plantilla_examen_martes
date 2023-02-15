import 'package:flutter/cupertino.dart';
import '../models/datum.dart';
import 'db_provider.dart';

class UserListProvider extends ChangeNotifier {
  List<Datum> users = [];

  Future<Datum> nuevoUser(Datum usuario) async {
    final id = await DBProvider.db.insertUsuario(usuario);
    this.users.add(usuario);
    notifyListeners();
    return usuario;
  }

  Future<List<Datum>> carregaUsuarios() async {
    final usuarios = await DBProvider.db.getAllUsers();
    this.users = [...usuarios];
    notifyListeners();
    return users;
  }

  esborraTots() async {
    final users = await DBProvider.db.deleteAll();
    this.users = [];
    notifyListeners();
  }

  esborraPerId(int id) async {
    final users = await DBProvider.db.deleteById(id);
    this.users.removeAt(users);
    notifyListeners();
  }
}
