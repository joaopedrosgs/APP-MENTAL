import 'package:app_mental/Screens/Reading/intervention_list.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class InterventionScreen extends StatelessWidget {
  final String readingGroup;

  InterventionScreen(this.readingGroup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          shadowColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: FittedBox(child: Text(readingGroup))),
      body: InterventionList(readingGroup),
    );
  }
}