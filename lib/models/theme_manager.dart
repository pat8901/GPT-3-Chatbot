import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Sets the theme of app
class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'dark';

  ThemeMode get themeMode {
    if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  // Changes the theme and saves it then notifies listeners
  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  // Gets theme from storage on startup
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentTheme = prefs.getString('theme') ?? 'dark';
    notifyListeners();
  }
}
