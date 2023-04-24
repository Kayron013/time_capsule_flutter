import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/pages/new_message/new_message.dart';
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
      floatingActionButton: _AddLinkFab(),
    );
  }
}

class _AddLinkFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        // color: Colors.white,
      ),
      onPressed: () async {
        bool? isScheduled = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewMessagePage()));

        if ((isScheduled ?? false) && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Message has been scheduled'),
            backgroundColor: Colors.green,
          ));
        }
      },
    );
  }
}
