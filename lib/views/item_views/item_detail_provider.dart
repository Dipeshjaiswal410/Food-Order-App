import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/views/item_views/item_model.dart';

class ItemDetailProvider with ChangeNotifier {
  int _itemQuantity = 1;
  int get itemQuantity => _itemQuantity;
  String _cartMessage = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get cartMessage => _cartMessage;

  //Increasing quantity function
  void increaseQuantity() {
    _itemQuantity++;
    notifyListeners();
  }

  //Decreasing quantity function
  void decreaseQuantity() {
    if (_itemQuantity > 1) {
      _itemQuantity--;
      notifyListeners();
    } else {
      _itemQuantity = 1;
      notifyListeners();
    }
  }

  //Writing Orders in Firestore database
  /*Future placeOrderFunction() async {
    try {
      await _firestore.collection("").doc(_auth.currentUser!.uid).set({
        "customerName": "",
        "itemName": "",
        "quantity": "",
        "address": "",
        "phone": "",
      });
    } catch (e) {
      print(e);
    }
  }*/

  //Add to user cart in firestore db
  Future addToCart(ItemModel itemsDetails) async {
    try {
      notifyListeners();
      await _firestore
          .collection("UserCart")
          .doc(_auth.currentUser?.email)
          .collection("cartItem")
          .doc(itemsDetails.itemName)
          .set({
        "itemName": itemsDetails.itemName,
        "itemPrice": itemsDetails.itemPrice,
        "itemAvailability": itemsDetails.itemAvailability,
        "itemImage": itemsDetails.itemImage,
        "itemDescription": itemsDetails.itemDescription,
      });
      _cartMessage = "Added to cart";
    } catch (e) {
      _cartMessage = e.toString();
      notifyListeners();
      print(e);
    }
  }
}
