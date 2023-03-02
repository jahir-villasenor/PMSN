import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/post_model.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => ListPostScreenState();
}

class ListPostScreenState extends State<ListPostScreen> {
  database_helper? helper;

  @override
  void initState() {
    super.initState();
    helper = database_helper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: helper!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return Widget;
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Ocurrio un error en la petición'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
