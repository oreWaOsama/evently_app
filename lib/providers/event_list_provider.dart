import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }
}