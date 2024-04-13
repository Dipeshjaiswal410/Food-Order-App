import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogOutProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _logoutMessage = '';
  bool _logoutSuccessfully = false;
  String get logoutMessage => _logoutMessage;
  bool get logoutSucessfully => _logoutSuccessfully;

  //SignUp Function
  Future logOutFunction() async {
    try {
      await _auth.signOut();
      notifyListeners();
      _logoutSuccessfully = true;
    } on FirebaseAuthException catch (e) {
      _logoutMessage = e.toString();
      notifyListeners();
    }
  }
}
