import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practica1/responsive.dart';

import '../widgets/onboarding_cards.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

// ignore: prefer_const_declarations
final datos = [
  CardView(
      title: "Nuestra Institución",
      subtitle:
          "El Tecnológico de Celaya ahora TecNM en Celaya, inicia actividades el 14 de abril de 1958 como un Centro de Segunda Enseñanza y Capacitación Técnica para Trabajadores. Actualmente su población estudiantil la conforman 6 mil 312 estudiantes, 6041 en programas de licenciatura y 271 en posgrado. El TecNM en Celaya por sus indicadores académicos, se coloca en los primeros lugares nacionales, se reconoce la calidad de sus programas académicos a nivel nacional e internacional, recientemente obtuvo la certificación del sistema integrado.",
      image: const AssetImage("assets/logo_itc.png"),
      backgroundColor: const Color.fromARGB(255, 18, 48, 7),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/ba1.json")),
  CardView(
      title: "Nuestra Ingenieria",
      subtitle:
          "La Ingenieria en Sistemas Computacionales se encarga del diseño, desenvolvimiento, puesta en marcha y mantenimiento de aplicaciones o programas informáticos (software), usando la tecnología actual. La ingeniería de sistemas computacionales aplica conocimientos matemáticos, de programación e incluso de electrónica para dar respuestas acordes a las necesidades del mundo empresarial, educativo y gubernamental, entre otros.",
      image: const AssetImage("assets/isc.jpeg"),
      backgroundColor: const Color.fromARGB(255, 45, 51, 45),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/bg-2.json")),
  CardView(
      title: "Nuestras Instalaciones",
      subtitle:
          "Campus 1: Antonio García Cubas Pte #600 esq. Av. Tecnológico Celaya, Gto. México.                                                                     Campus 2: Antonio García Cubas Pte #1200 esq. Ignacio Borunda Celaya, Gto. México                                                          ",
      image: const AssetImage("assets/instalaciones.png"),
      backgroundColor: const Color.fromARGB(255, 87, 78, 71),
      titleColor: Colors.green,
      subtitleColor: Colors.green,
      background: LottieBuilder.asset("assets/animations/ba1.json"))
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Responsive(
            mobile: ConcentricPageView(
              verticalPosition: BorderSide.strokeAlignInside,
              colors: const [Colors.green, Colors.teal, Colors.white],
              radius: 30,
              itemBuilder: (index) {
                final dato = datos[index % datos.length];
                return CardViews(data: dato);
              },
            ),
            desktop: ConcentricPageView(
              colors: const [Colors.green, Colors.teal, Colors.white],
              radius: 30,
              itemBuilder: (index) {
                final dato = datos[index % datos.length];
                return CardViews(data: dato);
              },
            ),
          ),
          const Responsive(
              mobile: Positioned(top: 600, left: 150, child: salir()),
              tablet: Positioned(top: 50, right: 50, child: salir()),
              desktop: Positioned(top: 100, right: 150, child: salir())),
        ],
      ),
    );
  }
}

class salir extends StatelessWidget {
  const salir({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: salir,
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      label: const Text('Salir'),
      icon: const Icon(Icons.keyboard_return),
      backgroundColor: Color.fromARGB(255, 181, 43, 19),
    );
  }
}
