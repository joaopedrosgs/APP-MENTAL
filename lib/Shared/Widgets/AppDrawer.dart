import 'package:app_mental/Screens/ChatPage/ChatPage.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 10);

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    final name = FirebaseAuth.instance.currentUser!.displayName ?? "Sem Email";
    final email = FirebaseAuth.instance.currentUser!.email ?? "Sem Nome";
    final image = 'assets/images/woman.png';
    final user =
        DatabaseMethods.chatUser ?? types.User(id: "", role: types.Role.user);
    print(user);
    return Drawer(
        child: Container(
      decoration: BoxDecoration(color: AppColors.verdementa),
      child: Column(children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          buildHeader(
              image: image,
              name: truncateWithEllipsis(10, name),
              email: email,
              onClicked: () => selectedItem(context, 4)),
          if (user.role == types.Role.user) ...[
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Home',
              icon: Icons.house,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Diário do sono',
              icon: Icons.bed,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Questionários',
              icon: Icons.list_alt,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Contatos',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 3),
            )
          ] else if (user.role == types.Role.agent) ...[
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Chat',
              icon: Icons.list_alt,
              onClicked: () => selectedItem(context, 4),
            ),
          ]
        ])),
        if (user.role == types.Role.user) ...[
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Falar com pesquisador'),
                          onTap: () => openChat(context))
                    ],
                  ))),
        ],
      ]),
    ));
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      DrawerHeader(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                maxRadius: 30,
                backgroundImage: AssetImage('assets/images/woman.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Olá, $name",
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Inter", fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                      fontFamily: "Inter", fontSize: 14, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      );

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.black;
    final hoverColor = AppColors.verdeclaro;

    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text,
            style: TextStyle(
                fontFamily: "Inter", fontSize: 15, color: Colors.black)),
        hoverColor: hoverColor,
        onTap: onClicked);
  }

  void openChat(BuildContext context) async {
    var user = await DatabaseMethods().getFirstContact();
    var room = await FirebaseChatCore.instance.createRoom(user);
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/logged-home");
        break;
      case 1:
        Navigator.pushNamed(context, "/sleep-diary");
        break;
      case 2:
        Navigator.pushNamed(context, "/quests-screen");
        break;
      case 3:
        Navigator.pushNamed(context, "/contacts-screen");
        break;
      case 4:
        Navigator.pushNamed(context, "/users");
        break;
    }
  }
}
