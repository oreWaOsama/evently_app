import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/utils/toast_utils.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> eventsFilteredList = [];
  List<Event> favoriteEventsFilteredList = [];
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

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection(uId).get();
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

  void changeIndex(int index, String id) {
    selectedIndex = index;
    if (index == 0) {
      eventsFilteredList = eventsList;
    } else {
      getFilteredEvents();
    }
    notifyListeners();
  }

  void upDateFavoriteEvent(Event event,String uId) async {
    FirebaseUtils.getEventsCollection(uId)
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ToastUtils.toastMsg(
              backgroundColor: ColorsManager.greenColor,
              textColor: ColorsManager.whiteColor,
              message: tr('favorite_updated_successfully'),
            );

            getAllFavoriteEvents(uId);
          },
        );
  }

  void getFilteredFavoriteEventsFromFireStore(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventsCollection(uId)
        .where('eventName', isEqualTo: eventsName[selectedIndex])
        .orderBy('dateTime')
        .get();

    eventsFilteredList = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  void getAllFavoriteEvents(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventsCollection(uId)
        .where('isFavorite', isEqualTo: true)
        .orderBy('dateTime')
        .get();

    favoriteEventsFilteredList = querySnapshot.docs
        .map((doc) => doc.data())
        .toList();
    notifyListeners();
  }
}
