import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:provider/provider.dart';
import '../provider/flags_provider.dart';

class ModalAddPost extends StatefulWidget {
  const ModalAddPost({super.key});

  @override
  State<ModalAddPost> createState() => _ModalAddPostState();
}

class _ModalAddPostState extends State<ModalAddPost> {
  database_helper? database;
  TextEditingController txtDescPost = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = database_helper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
      title: Text('Adding Post'),
      content: SizedBox(
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              maxLines: 5,
            ),
            IconButton(
                onPressed: () {
                  database!.INSERTAR('tblPost', {
                    'dscPost': txtDescPost.text,
                    'datePost': DateTime.now().toString(),
                  }).then((value) {
                    var msg =
                        value > 0 ? 'Registro Insertado!' : 'Ocurrio un error!';
                    final snackBar = SnackBar(content: Text(msg));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    flags.setupdatePosts();
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
