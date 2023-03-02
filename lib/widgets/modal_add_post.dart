import 'package:flutter/material.dart';

class ModalAddPost extends StatefulWidget {
  const ModalAddPost({super.key});

  @override
  State<ModalAddPost> createState() => _ModalAddPostState();
}

class _ModalAddPostState extends State<ModalAddPost> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adding Post'),
      content: TextFormField(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
