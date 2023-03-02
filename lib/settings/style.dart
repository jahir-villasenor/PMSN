import 'package:flutter/material.dart';

class StylesApp {
  //static Color appPrimaryColor = Color.fromARGB(255, 5, 156, 40);

  static ThemeData darkTheme(BuildContext context) {
    final ThemeData theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: Color.fromARGB(255, 0, 53, 0)),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: Color.fromARGB(255, 5, 156, 40)),
    );
  }
}
