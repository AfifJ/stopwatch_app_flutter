import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch_app/models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  UserModel firebaseToUserModel(User user) {
    return UserModel(username: user.uid, uid: user.uid, email: user.email!);
  }

  Future? signIn(String email, String password) async {
    try {
      UserCredential? user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return firebaseToUserModel(user.user!);
    } on FirebaseAuthException catch (e) {
      print('gagal login');
      print(e.code);
      return null;
    }
  }

  Future? signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Stream authStateChanges() {
    return _auth.authStateChanges();
  }

  UserModel currentUser() {
    return firebaseToUserModel(_auth.currentUser!);
  }
}
