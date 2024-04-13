import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  bool _passwordVisibility = true;

  String _signupMessage = '';
  bool get passwordVisibility => _passwordVisibility;

  String get signupMessage => _signupMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // SignUp Function
  Future signUpFuntion(String email, String password, String name, String phone,
      String address) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _signupMessage = "SignUp Successfully";

      await _firebaseFirestore.collection("UserCredintials").doc(email).set({
        'name': name,
        'phone': phone,
        'address': address,
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _signupMessage = e.toString();
      notifyListeners();
    }
  }

  //Writing data into firestore database...
  Future writingUserCredintial(
      String name, String phone, String address) async {
    _firebaseFirestore
        .collection("UserCredintials")
        .doc()
        .set({'name': name, 'phone': phone, 'address': address});
    notifyListeners();
  }

  //Visibility Function
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
