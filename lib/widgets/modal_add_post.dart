import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:provider/provider.dart';
import '../firebase/port_collection.dart';
import '../models/post_model.dart';
import '../provider/flags_provider.dart';

class ModalAddPost extends StatefulWidget {
  ModalAddPost({super.key, this.postModel});

  PostModel? postModel;

  @override
  State<ModalAddPost> createState() => _ModalAddPostState();
}

class _ModalAddPostState extends State<ModalAddPost> {
  PostCollection? postCollection;
  DatabaseHelper? database;
  TextEditingController txtDescPost = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
    postCollection = PostCollection();
    txtDescPost.text =
        widget.postModel != null ? widget.postModel!.dscPost! : '';
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
      title:
          widget.postModel == null ? Text('Adding Post') : Text('Editing Post'),
      content: SizedBox(
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: txtDescPost,
              maxLines: 5,
            ),
            IconButton(
                onPressed: () {
                  if (widget.postModel == null) {
                    postCollection!
                        .insertPost(
                      PostModel(
                          dscPost: txtDescPost.text,
                          datePost: DateTime.now().toString()),
                    )
                        .then((value) {
                      var msg = 'Registro insertado!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setflagListPost();
                    });

                    /*database!.INSERTAR('tblPost', {
                      'dscPost': txtDescPost.text,
                      'datePost': DateTime.now().toString(),
                    }).then((value) {
                      var msg = value > 0
                          ? 'Registro Insertado!'
                          : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setflagListPost();
                    });*/
                  } else {
                    postCollection!
                        .updatePost(
                      PostModel(
                          dscPost: txtDescPost.text,
                          datePost: DateTime.now().toString()),
                      widget.postModel!.idPost.toString(),
                    )
                        .then((value) {
                      var msg = 'Registro Actualizado!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setflagListPost();
                    });
                    /* database!
                        .ACTUALIZAR(
                            'tblPost',
                            {
                              'idPost': widget.postModel!.idPost,
                              'dscPost': txtDescPost.text,
                              'datePost': DateTime.now().toString(),
                            },
                            'idPost')
                        .then((value) {
                      var msg = value > 0
                          ? 'Registro Actualizado!'
                          : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setflagListPost();
                    });*/
                  }
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
