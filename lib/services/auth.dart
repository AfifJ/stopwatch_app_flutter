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
      print("GADA SINYAL" + e.code);
      switch (e.code) {
        case 'network-request-failed':
          return 'Internet tidak tersedia, tidak bisa login';
        case 'user-not-found':
          return 'Email tidak ditemukan.';
        case 'wrong-password':
          return 'Password yang anda massukkan salah.';
        case 'invalid-email':
          return 'Email yang anda masukkan tidak valid.';
        default:
          return 'Email atau password salah.';
      }
    }
  }

  Future? signUp(String email, String password) async {
    try {
      UserCredential? user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await signOut();
      return firebaseToUserModel(user.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email ini sudah digunakan.';
        case 'weak-password':
          return 'Password terlalu lemah.';
        case 'invalid-email':
          return 'Email yang anda masukkan tidak valid.';
        default:
          return 'Terjadi kesalahan saat mendaftar.';
      }
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
