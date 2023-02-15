import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:plantilla_examen/models/models.dart';
import 'package:plantilla_examen/providers/db_provider.dart';

class UserProviders extends ChangeNotifier {
  UserProviders() {
    hacerPeticion();
  }
  List<Datum> listaUsers = [];

  var base = "reqres.in";
  String endPoint = "api/users";
  var param = {"page": "1"};

  hacerPeticion() async {
    var url = Uri.https(base, endPoint, param);
    var response = await http.get(url);

    var userResponse = UsersResponse.fromJson(response.body);
    listaUsers = userResponse.data;
    notifyListeners();
  }
}
