import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_flutter/constants/routes.dart';
import 'package:time_capsule_flutter/pages/home.dart';
import 'package:time_capsule_flutter/pages/login.dart';
import 'package:time_capsule_flutter/pages/splash.dart';
import 'package:time_capsule_flutter/providers/auth.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: MaterialApp(
        title: 'Time Capsule',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
        routes: {
          Routes.login: (context) => const LoginPage(),
          Routes.home: (context) => const HomePage()
        },
      ),
    );
  }
}
