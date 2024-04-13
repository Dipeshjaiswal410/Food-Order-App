import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool _passwordVisibility = true;
  String _loginMessage = '';
  bool get passwordVisibility => _passwordVisibility;
  String get loginMessage => _loginMessage;

  SharedPreferences? loginStatus;

  //Function to check login status
  Future<bool> checkLoginStatus() async {
    loginStatus = await SharedPreferences.getInstance();
    //newUser = (loginStatus!.getBool('loginStatus') ?? true);
    if (loginStatus!.getBool("loginStatus") == true) {
      return true;
    } else {
      return false;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future logInFuntion(String email, String password) async {
    try {
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _loginMessage = "Login Successful";
    } on FirebaseAuthException catch (e) {
      _loginMessage = e.toString();
      notifyListeners();
    }
  }

  void changePasswordVisibility() {
    if (_passwordVisibility == true) {
      _passwordVisibility = false;

      notifyListeners();
    } else {
      _passwordVisibility = true;
      notifyListeners();
    }
  }
}
