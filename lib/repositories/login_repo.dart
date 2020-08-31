import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      }
    } catch (e) {
      print(e.toString());
      return 3;
    }
  }
}
