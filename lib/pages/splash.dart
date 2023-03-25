import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/constants/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
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
