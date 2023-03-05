import 'package:flutter/material.dart';
import 'package:practica1/settings/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;

  ThemeProvider(int id_tema, BuildContext context) {
    setthemeData(id_tema, context);
  }

  getthemeData() => this._themeData;
  setthemeData(int? index, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (index) {
      case 0:
        _themeData = StylesApp.lightTheme(context);
        sharedPreferences.setInt('id_tema', 0);
        await sharedPreferences.setBool('is_dark', false);
        break;
      case 1:
        _themeData = StylesApp.darkTheme(context);
        sharedPreferences.setInt('id_tema', 1);
        await sharedPreferences.setBool('is_dark', true);
        break;
      case 2:
        _themeData = StylesApp.warmTheme(context);
        sharedPreferences.setInt('id_tema', 2);
        break;
    }
    notifyListeners();
  }
}
