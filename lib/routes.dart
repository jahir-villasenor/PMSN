import 'package:flutter/material.dart';
import 'package:practica1/screen/dashbord_screen.dart';
import 'package:practica1/screen/login_screen.dart';
import 'package:practica1/screen/register_screen.dart';
import 'package:practica1/screen/onboard_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/knows': (BuildContext context) => OnBoardScreen(),
  };
}
