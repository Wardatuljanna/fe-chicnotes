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

  // Store the color based on note ID only when explicitly set
  Future<void> storeColor(String noteId, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedColor_$noteId', color.value);
  }

  // Retrieve the color for a specific note ID, or use a default if not set
  Future<Color> getColor(String noteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('selectedColor_$noteId');
    // Default color set here only if no color is found
    return colorValue != null ? Color(colorValue) : const Color(0xffffffff); // Default white color
  }
}
