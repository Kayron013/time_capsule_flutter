import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_capsule_flutter/constants/routes.dart';
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
          title: Text(data.recipient),
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
              onSaved: (value) async {
                var isSuccessful = await data.sendContent(value!);
                if (isSuccessful && context.mounted) {
                  Navigator.pop(context, true);
                }
              },
            ),
            subtitle: Text(
              data.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              if (data.state != MessageState.composeMessage &&
                  data.state != MessageState.storedFailure) return;

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
            icon: const Icon(FontAwesomeIcons.paperPlane))
      ],
    );
  }
}
