import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_flutter/pages/new_message/new_message.dart';
import 'package:time_capsule_flutter/utils/text.dart';
import 'package:time_capsule_flutter/widgets/app_drawer.dart';

import '../providers/db.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Capsule'),
      ),
      drawer: const AppDrawer(),
      body: ListView(children: [
        const Text('Scheduled'),
        _UnsentMessages(),
        const Text('Sent'),
        _SentMessages()
      ]),
      floatingActionButton: _AddLinkFab(),
    );
  }
}

class _UnsentMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageProvider>(
      create: (context) => MessageProvider.recentScheduled(),
      child: Consumer<MessageProvider>(
        builder: (context, data, child) {
          var messages = data.data ?? [];
          var tiles = messages
              .map((msg) => ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(msg.recipient),
                    subtitle: Text(TextUtil.ellipse(msg.content)),
                  ))
              .toList();
          return Column(
            children: tiles,
          );
        },
      ),
    );
  }
}

class _SentMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageProvider>(
      create: (context) => MessageProvider.recentSent(),
      child: Consumer<MessageProvider>(
        builder: (context, data, child) {
          var messages = data.data ?? [];
          var tiles = messages
              .map((msg) => ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(msg.recipient),
                    subtitle: Text(TextUtil.ellipse(msg.content)),
                  ))
              .toList();
          return Column(
            children: tiles,
          );
        },
      ),
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
