import 'package:flutter/material.dart';
import 'package:practica1/screen/list_post_cloud_screen.dart';
import 'package:practica1/settings/style.dart';
import 'package:provider/provider.dart';

import '../firebase/facebook_auth.dart';
import '../firebase/google_auth.dart';
import '../models/user_model.dart';
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
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TecBook'),
      ),
      body: ListPostCloudScreen(),
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
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl.toString()),
                ),
                accountName: Text(user!.name.toString()),
                accountEmail: Text(user!.email.toString())),
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
              // ignore: sort_child_properties_last
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
            ElevatedButton(
              // ignore: sort_child_properties_last
              child: Text(
                'About Us',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/aboutus');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ListTile(
              onTap: () {
                try {
                  googleAuth.signOutWithGoogle().then((value) {
                    if (value) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      print('no');
                    }
                  });
                  faceAuth.signOut().then((value) {
                    if (value) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      print('no');
                    }
                  });
                } catch (e) {
                  print(e);
                }
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
