import 'package:flutter/material.dart';
import 'package:practica1/settings/style.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context) {
    _themeData = StylesApp.lightTheme(context);
  }

  ThemeData? _themeData;
  getthemeData() => this._themeData;
  settthemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
