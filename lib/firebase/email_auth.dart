import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final emailAuth = FirebaseAuth.instance;

  Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await emailAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      userCredential.user!.sendEmailVerification();
      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> singInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await emailAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
        return true;
      }
    } catch (e) {}
    return false;
    
  }
}
