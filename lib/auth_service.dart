import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // VALIDATION
  String? validateEmail(String email) {
    if (email.isEmpty) return "Enter Email";
    if (!email.contains("@")) return "Invalid Email";
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Enter Password";
    if (password.length < 6) return "Min 6 chars required";
    return null;
  }

  //EMAIL SIGN UP
  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.user!.sendEmailVerification();
      return "Verify your email before login";
    } catch (e) {
      return e.toString();
    }
  }

  // EMAIL LOGIN
  Future<String?> login(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.user!.emailVerified) {
        await _auth.signOut();
        return "please verify your email";
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //GOOGLE SIGN IN
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return user.user;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
