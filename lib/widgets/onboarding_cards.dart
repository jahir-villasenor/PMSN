import 'package:flutter/material.dart';
import 'package:practica1/responsive.dart';

class CardView {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardView(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      this.background});
}

class CardViews extends StatelessWidget {
  const CardViews({required this.data, super.key});

  final CardView data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Responsive(
          mobile: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  SizedBox(
                    width: 200,
                    child: Flexible(
                      flex: 20,
                      child: Image(image: data.image),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    data.title.toUpperCase(),
                    style: TextStyle(
                      color: data.titleColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    maxLines: 1,
                  ),
                  const Spacer(flex: 1),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: data.subtitleColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 12,
                  ),
                  const Spacer(flex: 10),
                ],
              ),
            ),
          ),
          desktop: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  SizedBox(
                    width: 200,
                    child: Flexible(
                      flex: 20,
                      child: Image(image: data.image),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    data.title.toUpperCase(),
                    style: TextStyle(
                      color: data.titleColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    maxLines: 1,
                  ),
                  const Spacer(flex: 1),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: data.subtitleColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 12,
                  ),
                  const Spacer(flex: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
