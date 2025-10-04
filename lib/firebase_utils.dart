import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data();
            return Event.fromJson(data!);
          },
          toFirestore: (event, options) {
            return event.toJson();
          },
        );
  }

  static Future<void> addEventToFirestore(Event event) {
    final eventCollection = getEventsCollection();
    DocumentReference<Event> docRef = eventCollection.doc();
    event.id = docRef.id;
   return docRef.set(event);
  }
}
 