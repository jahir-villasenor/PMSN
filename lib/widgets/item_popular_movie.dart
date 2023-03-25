import 'package:flutter/material.dart';
import 'package:practica1/models/popular_model.dart';

class ItemPopularMovie extends StatelessWidget {
  ItemPopularMovie({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/loading.gif'),
      image: NetworkImage(
          'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}
