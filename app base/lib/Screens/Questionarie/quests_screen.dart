import 'package:chat_app_tutorial/Screens/ChatRoom/Widgets/calendar.dart';
import 'package:chat_app_tutorial/escalas/pcl5/pcl5_screen.dart';
import 'package:chat_app_tutorial/escalas/promisn1/promisn1_screen.dart';
import 'package:chat_app_tutorial/escalas/promisn2/promisn2_screen.dart';
import 'package:chat_app_tutorial/escalas/pset/pset_screen.dart';
import 'package:chat_app_tutorial/helper/constants.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestsScreen extends StatefulWidget {
  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream questsRoomsStream;

  Widget questsRoomList() {
    print('(((' + Constants.myEmail + ')))');
    return StreamBuilder<QuerySnapshot>(
      stream: questsRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return snapshot.data.docs[index].get("unanswered?")
                ? QuestRoomTile(
              snapshot.data.docs[index].get("questName"),
              snapshot.data.docs[index].get("questId"),
              snapshot.data.docs[index].get("availableAt").toDate(),
              snapshot.data.docs[index].get("userEscala"),
            )
                : UnavailableQuestRoomTile(
                snapshot.data.docs[index].get("questName"));
          },
        )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    Constants.myEmail = Constants.myEmail.trim();
    databaseMethods.getCreatedQuests(Constants.myEmail).then((val) {
      setState(() {
        questsRoomsStream = val;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(Constants.myEmail + "a");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: questsRoomList(),
    );
  }
}

class QuestRoomTile extends StatelessWidget {
  final String questName;
  final String questId;
  final DateTime availableAt;
  final String userEscala;
  final DateTime now = DateTime.now();
  final Map<String, dynamic> routes = {
    "pn1": Promisn1Screen.routeName,
    "pn2": Promisn2Screen.routeName,
    "pset": PsetScreen.routeName,
    "pcl5": Pcl5Screen.routeName,
  };

  QuestRoomTile(
      this.questName,
      this.questId,
      this.availableAt,
      this.userEscala,
      );

  @override
  Widget build(BuildContext context) {
    var nextSunday = getNextSunday(availableAt);
    print('nextSunday: $nextSunday');
    print('availableAt: $availableAt');
    print('now: $now');
    if (now.isAfter(availableAt) && now.isBefore(nextSunday)) {
      return Container(
          width: double.infinity,
          child: Column(
            children: [
              ListTile(
                  title: Text(questName),
                  onTap: () {
                    Navigator.of(context).pushNamed(routes[questId],
                        arguments: {
                          'title': questName,
                          "userEscala": userEscala
                        });
                  }),
              Divider(thickness: 2.0),
            ],
          ));
    } else {
      return Container();
    }
  }
}

class UnavailableQuestRoomTile extends StatelessWidget {
  final String questName;

  UnavailableQuestRoomTile(this.questName);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              title: Text("${questName} - Já respondido!"),
            ),
            Divider(thickness: 2.0),
          ],
        ));
  }
}