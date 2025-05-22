import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _animationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  bool get animationsEnabled => _animationsEnabled;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    _animationsEnabled = prefs.getBool('animations') ?? true;
    notifyListeners();
  }

  void setDarkMode(bool val) async {
    _isDarkMode = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', val);
    notifyListeners();
  }

  void setAnimationsEnabled(bool val) async {
    _animationsEnabled = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('animations', val);
    notifyListeners();
  }
}