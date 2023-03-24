import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:time_capsule_flutter/providers/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var user = auth.user;

    if (user != null) {
      print('Signed in. UID: ${user.uid}');
      // Can't navigate during build; wait until build finished
      // Causes login page to exist for a bit before navigating
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.Google,
              onPressed: () {
                auth.signInWithGoogle();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
