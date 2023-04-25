import 'package:flutter/material.dart';
import 'package:practica1/responsive.dart';
import 'package:practica1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../firebase/email_auth.dart';
import '../firebase/facebook_auth.dart';
import '../firebase/google_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  EmailAuth emailAuth = EmailAuth();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();
  TextEditingController? txtemailCont = TextEditingController();
  TextEditingController? txtPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email User'), enabledBorder: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final spaceHorizontal = const SizedBox(
      height: 8,
    );

    final btnLogin = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        print(txtemailCont!.text);
        print(txtPassController!.text);
        emailAuth!
            .singInWithEmailAndPassword(
                email: txtemailCont!.text, password: txtPassController!.text)
            .then((value) {
          if (value) {
            Navigator.pushNamed(context, '/dash');
            isLoading = false;
          } else {
            isLoading = false;
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
        });
      },
    );

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () async {
        isLoading = true;
        setState(() {});
        await googleAuth.signInWithGoogle().then((value) {
          if (value.name != null) {
            isLoading = false;
            Navigator.pushNamed(context, '/dash', arguments: value);
          } else {
            isLoading = false;
            setState(() {});
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
        });
      },
    );

    final btnFacebook = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      onPressed: () async {
        isLoading = true;
        setState(() {});
        faceAuth.signInWithFacebook().then((value) {
          if (value.name != null) {
            Navigator.pushNamed(context, '/dash', arguments: value);
            isLoading = false;
          } else {
            isLoading = false;
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
          setState(() {});
        });
      },
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Crear cuenta :',
              style: TextStyle(decoration: TextDecoration.underline))),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fondo_itc.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Responsive(
                mobile: MobileLoginScreen(
                    txtEmail: txtEmail,
                    spaceHorizontal: spaceHorizontal,
                    txtPass: txtPass,
                    btnLogin: btnLogin,
                    btnGoogle: btnGoogle,
                    btnFacebook: btnFacebook,
                    txtRegister: txtRegister),
                tablet: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            width: 150,
                            child: Center(child: Imagen()),
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                width: 40,
                                child: Center(child: conocenos()),
                              ),
                              const SizedBox(
                                width: 45,
                                child: Center(child: settings()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 450,
                            child: LoginForm(
                                txtEmail: txtEmail,
                                spaceHorizontal: spaceHorizontal,
                                txtPass: txtPass,
                                btnLogin: btnLogin,
                                btnGoogle: btnGoogle,
                                btnFacebook: btnFacebook,
                                btnRegister: txtRegister),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                desktop: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            width: 450,
                            child: Center(child: Imagen()),
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                width: 400,
                                child: Center(child: conocenos()),
                              ),
                              const SizedBox(
                                width: 45,
                                child: Center(child: settings()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 450,
                            child: LoginForm(
                                txtEmail: txtEmail,
                                spaceHorizontal: spaceHorizontal,
                                txtPass: txtPass,
                                btnLogin: btnLogin,
                                btnGoogle: btnGoogle,
                                btnFacebook: btnFacebook,
                                btnRegister: txtRegister),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}

class Imagen extends StatelessWidget {
  const Imagen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo_itc.png',
      height: 250,
    );
  }
}

class conocenos extends StatelessWidget {
  const conocenos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: conocenos,
      onPressed: () {
        Navigator.pushNamed(context, '/knows');
      },
      label: const Text('Conocenos'),
      icon: const Icon(Icons.thumb_up),
      backgroundColor: const Color.fromARGB(255, 25, 143, 31),
    );
  }
}

class settings extends StatelessWidget {
  const settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: settings,
      onPressed: () {
        Navigator.pushNamed(context, '/settings');
      },
      child: Icon(Icons.settings),
      backgroundColor: Color.fromARGB(255, 155, 155, 155),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm(
      {super.key,
      required this.txtEmail,
      required this.spaceHorizontal,
      required this.txtPass,
      required this.btnLogin,
      required this.btnGoogle,
      required this.btnFacebook,
      required this.btnRegister});

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final Padding btnRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtEmail,
        txtPass,
        btnLogin,
        const Text("or"),
        btnGoogle,
        btnFacebook,
        btnRegister,
      ],
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.txtRegister,
  });
  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Imagen(),
        txtEmail,
        spaceHorizontal,
        txtPass,
        spaceHorizontal,
        btnLogin,
        spaceHorizontal,
        const Text('or'),
        spaceHorizontal,
        btnGoogle,
        spaceHorizontal,
        btnFacebook,
        txtRegister,
        Row(
          children: const [conocenos(), settings()],
        )
      ],
    );
  }
}
