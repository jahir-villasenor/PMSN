import 'package:flutter/material.dart';
import 'package:practica1/responsive.dart';
import 'package:practica1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

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

    final spaceHorizontal = SizedBox(
      height: 15,
    );

    final btnLogin = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });
        });

    final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google, onPressed: () {});

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook, onPressed: () {});

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
                          width: 250,
                          child: Center(child: Imagen()),
                        ),
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
        const Padding(padding: EdgeInsets.all(8.0)),
        Imagen(),
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
        spaceHorizontal,
        txtRegister
      ],
    );
  }
}
