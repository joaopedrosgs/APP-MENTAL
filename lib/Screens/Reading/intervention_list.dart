import 'package:app_mental/Screens/Reading/Widgets/intervention_card.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/reading_database.dart';
import '../../model/reading.dart';
import '../../model/reading_rel_user_dto.dart';

class InterventionList extends StatefulWidget {
  final String readingGroup;
  final List<ReadingRelUserDTO> notificationList;
  final Function callback;

  InterventionList(this.readingGroup, this.notificationList, this.callback);

  @override
  State<InterventionList> createState() => _InterventionListState();
}

class _InterventionListState extends State<InterventionList> {
  List<Reading> readingList = [];

  @override
  void initState() {
    getReadingDatabase();
    super.initState();
  }

  getReadingDatabase() async {
    await ReadingDatabase.instance
        .getReadingsByGroup2(widget.readingGroup)
        .then((readings) {
      setState(() {
        readingList = readings;
      });
    });
  }

  removeNameFromNotificationList(element) {
    setState(() {
      widget.notificationList.remove(element);
      widget.callback(widget.notificationList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: AppColors.cinzamedio,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: readingList.length,
                  itemBuilder: (context, index) {
                    var reading = readingList.elementAt(index);
                    return InterventionCard(
                        reading: reading,
                        notificationList: widget.notificationList,
                        group: widget.readingGroup,
                        callback: removeNameFromNotificationList);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
