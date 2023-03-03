import 'package:flutter/material.dart';

class CardTecnm {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardTecnm(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      this.background});
}

class CardTec extends StatelessWidget {
  const CardTec({required this.data, super.key});

  final CardTecnm data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(data.background != null) data.background! ,
        Image(image: data.image),
        Text(data.title.toUpperCase()),
        Text(data.subtitle)
      ],
    );
  }
}
