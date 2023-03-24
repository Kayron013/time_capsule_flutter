import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_capsule_flutter/firebase_options.dart';

class AuthProvider extends ChangeNotifier {
  static final _auth = FirebaseAuth.instance;

  AuthProvider() {
    init();
  }

  User? _user;
  User? get user => _user;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    _auth.userChanges().listen((user) {
      _user = user;
      debugPrint('User: $user');
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    var googleAccount = await GoogleSignIn().signIn();
    // Flow was cancelled
    if (googleAccount == null) return;

    var credential = await googleAccount.authentication;
    var authCredential = GoogleAuthProvider.credential(
        idToken: credential.idToken, accessToken: credential.accessToken);
    await _auth.signInWithCredential(authCredential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
