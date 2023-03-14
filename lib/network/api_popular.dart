import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica1/models/popular_model.dart';

class ApiPopular {
  final URL =
      "https://api.themoviedb.org/3/movie/popular?api_key=74cb6acbf08ed4fda98c32157e6ee37c&language=es-MX&page=1";

  Future<List<PopularModel>?> getAllPopular() async {
    final response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular =
          popular.map((video) => PopularModel.fromMap(video)).toList();

      return listPopular;
    }
    return null;
  }
}
