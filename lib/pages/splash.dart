// import 'package:cogef_events_mobile/constants/routes.dart';
// import 'package:cogef_events_mobile/managers/AuthManager.dart';
// import 'package:cogef_events_mobile/singletons/AppUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/constants/routes.dart';
import 'package:time_capsule_flutter/firebase_options.dart';
// import 'package:sprinkle/SprinkleExtension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthManager manager = context.use<AuthManager>();
    // manager.user$.listen((user) {
    //   var route = user == null ? Routes.login : Routes.home;
    //   setAppUser(user);
    //   Navigator.pushReplacementNamed(context, route);
    // });

    // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
    //     .then((value) => () {
    //           debugPrint('firebase initialized');
    //           Navigator.pushReplacementNamed(context, Routes.login);
    //         })
    //     .catchError((error) {
    //   debugPrint('error initializing firebase: $error');
    //   Navigator.pushReplacementNamed(context, Routes.login);
    // });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
            ),
            Text('Loading auth service')
          ],
        ),
      ),
    );
  }
}
