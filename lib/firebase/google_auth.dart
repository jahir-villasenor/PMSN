import 'package:practica1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<UserModel> signInWithGoogle() async {
    this.signOutWithGoogle();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel user = UserModel.fromFirebaseUser(userCredential.user!);
      return user;
    } catch (e) {
      print(e);
      return UserModel(name: null);
    }
  }

  Future<bool> registerWithGoogle() async {
    this.signOutWithGoogle();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: googleUser.email,
        password: googleAuth.accessToken.toString(),
      );
      await userCredential.user!.linkWithCredential(credential);
      userCredential.user!.sendEmailVerification();
      print('User registered: ${userCredential.user}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
