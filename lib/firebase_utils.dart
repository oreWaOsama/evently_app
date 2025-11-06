import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:evently_app/model/event.dart';

class FirebaseUtils {
  static final _db = FirebaseFirestore.instance;

  // ========== USERS ==========
  static CollectionReference<MyUser> getUsersCollection() {
    return _db.collection(MyUser.collectionName).withConverter<MyUser>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data() ?? {};
        return MyUser(
          id: snapshot.id,   
          name: (data['name'] ?? '') as String,
          email: (data['email'] ?? '') as String,
        );
      },
      toFirestore: (myUser, _) => myUser.toFireStore(), 
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser) async {
    if (myUser.id.isEmpty) throw StateError('Missing uid for MyUser');
    await getUsersCollection()
        .doc(myUser.id)
        .set(myUser, SetOptions(merge: true));
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    final docSnap = await getUsersCollection().doc(id).get();
    return docSnap.data();  
  }

  // ========== EVENTS=========
  static CollectionReference<Event> getEventsCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Event.collectionName)    
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  static Future<void> addEventToFirestore(Event event, String uId) async {
    final ref = getEventsCollection(uId).doc();
    event.id = ref.id;
    await ref.set(event);
  }
}
