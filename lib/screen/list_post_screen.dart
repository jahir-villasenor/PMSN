import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:practica1/models/post_model.dart';
import 'package:practica1/widgets/item_post_widget.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  database_helper? helper;

  @override
  void initState() {
    super.initState();
    helper = database_helper();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: helper!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostWidget(postModel: objPostModel);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Ocurrió un error en la petición :)'),
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
