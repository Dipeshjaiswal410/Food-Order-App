import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PlaceOrderProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _orderMessage = '';
  String get orderMessage => _orderMessage;

  //Get User Details from firestore db
  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("UserCredintials")
          .doc(_auth.currentUser?.email)
          .get();
      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //Writing Orders in Firestore database
  Future placeOrderFunction(String customerName, String phone, String address,
      String itemName, String quantity, String price) async {
    try {
      Timestamp currentTime = Timestamp.now();
      String documentId = currentTime.toDate().toString();
      await _firestore.collection("customerOrders").doc(documentId).set({
        "customerName": customerName,
        "phone": phone,
        "address": address,
        "itemName": itemName,
        "quantity": quantity,
        "price": price,
      });
      _orderMessage = 'Order Placed Successfully!';
      notifyListeners();
    } catch (e) {
      _orderMessage = e.toString();
      notifyListeners();
    }
  }
}
