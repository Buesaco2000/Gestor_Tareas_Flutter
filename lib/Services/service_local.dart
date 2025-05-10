import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocal {
  static Future<void> guardarUsuario(String usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', usuario);
  }

  static Future<String?> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('usuario');
  }
}
