import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/pages/new_message/provider.dart';

class RecipientSelect extends StatelessWidget {
  final NewMessageProvider data;
  RecipientSelect({super.key, required this.data});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            ListTile(
              title: TextFormField(
                decoration: const InputDecoration(labelText: 'To'),
                validator: (value) {
                  debugPrint('value: "$value"');
                  var usNumberRegexp = RegExp(r'^(\+1)?\d{10}$');

                  if (!usNumberRegexp.hasMatch(value ?? '')) {
                    return 'Invalid number format';
                  }

                  return null;
                },
                onSaved: (value) {
                  data.setRecipients([value!]);
                },
              ),
            ),
            ListTile(
              title: TextButton(
                  child: const Text('Next'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  }),
            ),
          ],
        ));
  }
}
