import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  Future<bool> checkUserSigned() async {
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(milliseconds: 1000));
    return user != null;
  }

  Future<String> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user?.updateProfile(displayName: name);
      FirebaseAuth.instance.signOut();
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'รหัสผ่านสั้นเกินไป';
      } else if (e.code == 'email-already-in-use') {
        return 'มีบัญชีนี้อยู่ในระบบแล้ว';
      }
      return 'การสมัครบัญชีผู้ใช้มีปัญหา';
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'ไม่พบอีเมลนี้ในระบบ';
      } else if (e.code == 'wrong-password') {
        return 'รหัสผ่านไม่ถูกต้อง';
      }
      return 'อีเมล หรือ รหัสผ่านไม่ถูกต้อง';
    }
  }
}
