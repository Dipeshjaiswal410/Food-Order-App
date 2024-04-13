import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //Toast Message
  static toastMessage(String message, Color messageColor) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: messageColor,
        textColor: Colors.black,
        fontSize: 20,
        toastLength: Toast.LENGTH_SHORT);
  }
}
