import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_capsule_flutter/pages/new_message/provider.dart';

class MessageCompose extends StatelessWidget {
  final NewMessageProvider data;
  MessageCompose({super.key, required this.data});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Text('To:'),
          title: Text(data.recipients.join(', ')),
        ),
        Form(
          key: _formKey,
          child: ListTile(
            title: TextFormField(
              minLines: 6,
              maxLines: null,
              enabled: data.state == MessageState.composeMessage,
              initialValue: data.content,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Did you forget your message?';
                }
                return null;
              },
              onSaved: (value) {
                data.setContent(value!);
              },
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              if (data.state != MessageState.composeMessage) return;

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
            icon: const Icon(FontAwesomeIcons.paperPlane))
      ],
    );
  }
}
