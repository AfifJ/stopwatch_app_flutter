import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch_app/models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  UserModel firebaseToUserModel(User user) {
    return UserModel(username: user.uid, uid: user.uid);
  }

  Future? signIn(String email, String password) async {
    try {
      UserCredential? user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return firebaseToUserModel(user.user!);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    print('gagal login');
    return null;
  }
}
