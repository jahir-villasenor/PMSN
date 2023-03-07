import '../responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practica1/provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Stack(
        children: [
          Responsive(
            mobile: buildMobileLayout(theme, context),
            desktop: buildDesktopLayout(theme, context),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(ThemeProvider theme, BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleccione un tema',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(
                  heroTag: Icons.light,
                  onPressed: () {
                    theme.setthemeData(0, context);
                  },
                  label: const Text('Light Theme'),
                  icon: const Icon(Icons.light_mode),
                  backgroundColor: Color.fromARGB(255, 141, 141, 141),
                ),
                FloatingActionButton.extended(
                  heroTag: Icons.dark_mode,
                  onPressed: () {
                    theme.setthemeData(1, context);
                  },
                  label: const Text('Dark Theme'),
                  icon: const Icon(Icons.dark_mode),
                  backgroundColor: Color.fromARGB(255, 20, 20, 20),
                ),
                FloatingActionButton.extended(
                  heroTag: Icons.hot_tub,
                  onPressed: () {
                    theme.setthemeData(2, context);
                  },
                  label: const Text('Warm Theme'),
                  icon: const Icon(Icons.hot_tub),
                  backgroundColor: Color.fromARGB(255, 228, 172, 68),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(
                  heroTag: Icons.save,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  label: const Text('Guardar'),
                  icon: const Icon(Icons.save),
                  backgroundColor: Color.fromARGB(255, 55, 202, 80),
                ),
                FloatingActionButton.extended(
                  heroTag: Icons.cancel,
                  onPressed: () {
                    theme.setthemeData(0, context);
                    Navigator.pushNamed(context, '/login');
                  },
                  label: const Text('Salir'),
                  icon: const Icon(Icons.cancel),
                  backgroundColor: Color.fromARGB(255, 182, 16, 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDesktopLayout(ThemeProvider theme, BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 600,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccione un tema',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      theme.setthemeData(0, context);
                    },
                    label: const Text('Light Theme'),
                    icon: const Icon(Icons.light_mode),
                    backgroundColor: Color.fromARGB(255, 141, 141, 141),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      theme.setthemeData(1, context);
                    },
                    label: const Text('Dark Theme'),
                    icon: const Icon(Icons.dark_mode),
                    backgroundColor: Color.fromARGB(255, 20, 20, 20),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      theme.setthemeData(2, context);
                    },
                    label: const Text('Warm Theme'),
                    icon: const Icon(Icons.hot_tub),
                    backgroundColor: Color.fromARGB(255, 228, 172, 68),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    label: const Text('Guardar'),
                    icon: const Icon(Icons.save),
                    backgroundColor: Color.fromARGB(255, 55, 202, 80),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      theme.setthemeData(0, context);
                      Navigator.pushNamed(context, '/login');
                    },
                    label: const Text('Salir'),
                    icon: const Icon(Icons.cancel),
                    backgroundColor: Color.fromARGB(255, 182, 16, 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
