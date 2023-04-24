import 'package:flutter/material.dart';
import 'package:time_capsule_flutter/pages/new_message/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
              title: IntlPhoneField(
                decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(borderSide: BorderSide())),
                initialCountryCode: 'US',
                onSaved: (value) {
                  data.setRecipient(value?.completeNumber ?? '');
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
