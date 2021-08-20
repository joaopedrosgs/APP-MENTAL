import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kTextColorGreen,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/logged-home");
            },
          ),
          ListTile(
            title: const Text('Diário do sono'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/sleep-diary");
            },
          ),
          ListTile(
            title: const Text('Chat'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/chat");
            },
          ),
          ListTile(
            title: const Text('Questionários'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/quests-screen");
            },
          ),
          ListTile(
            title: const Text('Contatos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/contacts-screen");
            },
          ),
        ],
      ),
    );
  }
}
