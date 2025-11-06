import 'package:evently_app/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updatUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
