import 'package:flutter/material.dart';

class ChooseRecipient extends StatelessWidget {
  ChooseRecipient({super.key});

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
              ),
            ),
            ListTile(
              title: TextButton(
                  child: const Text('Compose'),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseRecipient()));
                  }),
            ),
          ],
        ));
  }
}
