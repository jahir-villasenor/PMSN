import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:practica1/settings/style.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TecBook'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.tenor.com/3sRGst4MU7AAAAAM/minecraft-minecraft-online.gif'),
                ),
                accountName: Text('Jahir Villaseñor Celorio'),
                accountEmail: Text('19030919@itcelaya.edu.mx')),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkThemeEnable,
              onStateChanged: (isDarkModeEnabled) {
                isDarkModeEnabled
                    ? theme.settthemeData(StylesApp.darkTheme(context))
                    : theme.settthemeData(StylesApp.lightTheme(context));

                isDarkThemeEnable = isDarkModeEnabled;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}