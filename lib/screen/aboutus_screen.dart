import 'dart:async';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kITC = CameraPosition(
    target: LatLng(20.541087, -100.8139196),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  //int optMap = 0;

  ValueNotifier<int> optMap = ValueNotifier<int>(0);
  final List<MapType> listmaptypes = [
    MapType.normal,
    MapType.satellite,
    MapType.hybrid,
    MapType.terrain
  ];

  @override
  Widget build(BuildContext context) {
    final circularMenu = CircularMenu(items: [
      CircularMenuItem(icon: Icons.home, onTap: () => optMap.value = 0),
      CircularMenuItem(icon: Icons.search, onTap: () => optMap.value = 1),
      CircularMenuItem(icon: Icons.settings, onTap: () => optMap.value = 2),
      CircularMenuItem(icon: Icons.star, onTap: () => optMap.value = 3),
    ]);

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: optMap,
              builder: (context, value, child) {
                return GoogleMap(
                  initialCameraPosition: _kITC,
                  mapType: listmaptypes[value],
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                );
              }),
          circularMenu
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To The Lake'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
