import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _user = "";
  static String _password = "";
  static bool _guardar = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get guardar {
    return _prefs.getBool('guardar') ?? _guardar;
  }

  static set guardar(bool guardar) {
    _guardar = guardar;
    _prefs.setBool('guardar', _guardar);
  }

  static String get user {
    return _prefs.getString('user') ?? _user;
  }

  static set user(String usuario) {
    _user = usuario;
    _prefs.setString('user', usuario);
  }

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password(String password) {
    _password = password;
    _prefs.setString('password', password);
  }
}
