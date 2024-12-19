import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> storeUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }

  Future<String?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  // Token storage and retrieval
  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  // Color storage for each note
  Future<void> storeColor(String noteId, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedColor_$noteId', color.value);
  }

  Future<Color> getColor(String noteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('selectedColor_$noteId');
    return colorValue != null ? Color(colorValue) : const Color(0xffffffff);
  }
}
