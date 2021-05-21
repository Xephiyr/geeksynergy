// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:randomtest/the_user.dart' as global

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();
bool num;
bool done;
String name;
String email;
String imageUrl;
//String _verificationId;

Future<String> signInEmail(String semail, String spassword) async {
  await Firebase.initializeApp();

  final AuthCredential cred = EmailAuthProvider.credential(email: semail, password: spassword);
  final UserCredential authResult = await _auth.signInWithCredential(cred);
  final User user = authResult.user;

  if (user != null) {
    print('$user');
    return '$user';
  }
  return null;
}

Future<String> registerEmail(String email, String password, String name) async {
  await Firebase.initializeApp();

  final User user = (await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ))
      .user;
  if (user != null) {
    user.updateProfile(displayName: name);
    return '$user';
  } else
    return null;
}

Future<void> signOutEmail() async {
  await _auth.signOut();

  print("User Signed Out");
}
