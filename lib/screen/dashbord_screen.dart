import 'package:flutter/material.dart';
import 'package:practica1/settings/style.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/future_modal.dart';
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
      body: flags.getflagListPost() == true
          ? const ListPostScreen()
          : const ListPostScreen(),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            openCustomDialog(context, null);
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.movie),
              title: const Text(
                'API Movies',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/pokemon');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.catching_pokemon),
              title: const Text(
                'API Pokémon',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
            ElevatedButton(
              child: Text(
                'Mis eventos',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/events');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }
}
