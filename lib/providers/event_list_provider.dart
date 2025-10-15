import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> eventsFilteredList = [];
  List<String> eventsName = [
    tr('all'),
    tr('sport'),
    tr('birthday'),
    tr('meeting'),
    tr('gaming'),
    tr('workshop'),
    tr('book_club'),
    tr('exhibition'),
    tr('holiday'),
    tr('eating'),
  ];

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
    eventsFilteredList = eventsList;

    eventsFilteredList.sort(
      (event1, event2) => event1.dateTime.compareTo(event2.dateTime),
    );
    notifyListeners();
  }

  void getFilteredEvents() {
    eventsFilteredList = eventsList.where((event) {
      return event.eventName == eventsName[selectedIndex];
    }).toList();
    eventsFilteredList.sort(
      (event1, event2) => event1.dateTime.compareTo(event2.dateTime),
    );
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    if (index == 0) {
      eventsFilteredList = eventsList;
    } else {
      getFilteredEvents();
    }
    notifyListeners();
  }
}
