import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:practica1/settings/style.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/modal_add_post.dart';
import 'list_post_screen.dart';

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
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TecBook'),
      ),
      body: flags.getupdatePosts() == true
          ? const ListPostScreen()
          : const ListPostScreen(),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            _openCustomDialog();
          },
          icon: Icon(Icons.add_comment),
          label: Text('Post it!')),
      drawer: Drawer(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.tenor.com/3sRGst4MU7AAAAAM/minecraft-minecraft-online.gif'),
                ),
                accountName: Text('Jahir Villaseñor Celorio'),
                accountEmail: Text('19030919@itcelaya.edu.mx')),
          ],
        ),
      ),
    );
  }

  _openCustomDialog() {
    return showGeneralDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(.5),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return Transform.scale(
            scale: animation.value,
            child: Opacity(
              opacity: animation.value,
              child: const ModalAddPost(),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: ((context, animation, secondaryAnimation) {
          return Container();
        }));
  }
}
