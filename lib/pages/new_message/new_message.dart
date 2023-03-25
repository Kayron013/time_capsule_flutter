import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_flutter/pages/new_message/message_compose.dart';
import 'package:time_capsule_flutter/pages/new_message/recipient_select.dart';
import 'package:time_capsule_flutter/pages/new_message/provider.dart';

class NewMessagePage extends StatelessWidget {
  const NewMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New message')),
      body: ChangeNotifierProvider<NewMessageProvider>(
        create: (context) => NewMessageProvider(),
        child: Consumer<NewMessageProvider>(builder: (context, data, child) {
          switch (data.state) {
            case MessageState.selectRecipients:
              return RecipientSelect(
                data: data,
              );
            case MessageState.composeMessage:
            case MessageState.storingMessage:
            case MessageState.storedSuccess:
            case MessageState.storedFailure:
              return MessageCompose(
                data: data,
              );
          }
        }),
      ),
    );
  }
}
