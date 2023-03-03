import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/onboarding_cards.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

// ignore: prefer_const_declarations
final datos = [
  CardTecnm(
      title: "Page 1",
      subtitle: "Subtitulo 1",
      image: const AssetImage("assets/logo_itc.png"),
      backgroundColor: const Color.fromRGBO(17, 34, 11, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animations/bg-2.json")),
  CardTecnm(
      title: "Page 1",
      subtitle: "Subtitulo 1",
      image: const AssetImage("assets/logo_itc.png"),
      backgroundColor: const Color.fromRGBO(75, 226, 61, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animations/bg-2.json")),
  CardTecnm(
      title: "Page 1",
      subtitle: "Subtitulo 1",
      image: const AssetImage("assets/logo_itc.png"),
      backgroundColor: const Color.fromRGBO(173, 87, 29, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animations/bg-2.json"))
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: [Colors.white, Colors.blue, Colors.red],
        radius: 50,
        itemBuilder: (index) {
          final dato = datos[index % datos.length];
          return CardTec(data: dato);
        },
      ),
    );
  }
}
