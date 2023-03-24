import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Capsule'),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: const [Text('You\'re logged in!')],
      ),
    );
  }
}
