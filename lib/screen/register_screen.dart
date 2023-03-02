import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  String? imagePath;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final floatingActionButton = FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 34, 129, 91),
      onPressed: () {
        _showSelectionDialog(context);
      },
      // ignore: prefer_const_constructors
      child: Icon(Icons.camera_alt),
    );
    // ignore: prefer_const_constructors
    final spaceHorizontal = SizedBox(
      height: 15,
    );


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/fondo_itc.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                key: _formKey,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _setImageView(),
                      spaceHorizontal,
                      floatingActionButton,
                      const MyCustomForm()
                    ],
                  ),
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container(),
          (imagePath == null) ? Container() : Image.file(File(imagePath!))
        ],
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(
        File(imageFile!.path),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.5,
      );
    } else {
      return const Text(
        "Por Favor, selecciona una imagen.",
        style: TextStyle(
          color: Color.fromARGB(255, 34, 129, 91),
          fontSize: 20,
        ),
      );
    }
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final txtName = TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Inserte su Nombre',
        labelText: 'Nombre',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    final txtEmail = TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.email),
        hintText: 'Inserte su email',
        labelText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email can not be empty";
        } else if (!EmailValidator.validate(value, true)) {
          return "Invalid Email Address";
        } else {
          return null;
        }
      },
    );

    final txtPass = TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Inserte su contraseña',
        labelText: 'Contraseña',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    // ignore: prefer_const_constructors
    final spaceHorizontal = SizedBox(
      height: 15,
    );

    final btnRegister = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        });
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          spaceHorizontal,
          txtName,
          spaceHorizontal,
          txtEmail,
          spaceHorizontal,
          txtPass,
          spaceHorizontal,
          btnRegister,
        ],
      ),
    );
  }
}
