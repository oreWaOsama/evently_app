import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> toastMsg({
    required Color backgroundColor,
    required Color textColor,
    required String message,
  }) {
    return Fluttertoast.showToast(

      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,

    );
  }
}
