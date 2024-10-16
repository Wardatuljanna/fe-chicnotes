import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  storeUser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }

  removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('user');
  }

  // Simpan warna yang dipilih berdasarkan ID catatan
  Future<void> storeColor(String noteId, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedColor_$noteId', color.value);
  }

  // Ambil warna yang dipilih berdasarkan ID catatan
  Future<Color> getColor(String noteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('selectedColor_$noteId');
    return colorValue != null ? Color(colorValue) : const Color(0xffF7F7F7); // Default color
  }
}
