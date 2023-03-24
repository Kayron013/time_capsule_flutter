import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_flutter/constants/routes.dart';
import 'package:time_capsule_flutter/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var user = auth.user;

    if (user == null) {
      return Drawer(
        child: Column(children: const []),
      );
    }

    return Drawer(
        child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(user.email ?? ''),
          accountName: Text(user.displayName ?? ''),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL ?? ''),
          ),
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.signOutAlt),
          title: const Text('Sign Out'),
          onTap: () {
            auth.signOut().then((value) {
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, Routes.login);
            });
          },
        ),
      ],
    ));
  }
}
