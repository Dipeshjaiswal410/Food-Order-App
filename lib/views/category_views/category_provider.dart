import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering/views/category_views/category_model.dart';
import 'package:food_ordering/views/item_views/item_model.dart';

class CategoryProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CategoryModel> _categories = [];

  List<ItemModel> _categoryItems = [];

  List<CategoryModel> get categories => _categories;
  List<ItemModel> get categoryItems => _categoryItems;

  // List of Catgory...
  Future<void> fetchCategories() async {
    try {
      // Replace 'categories' with the name of your Firestore collection
      QuerySnapshot querySnapshot =
          await _firestore.collection('CategoryList').get();

      _categories = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CategoryModel(
          categoryName: data['categoryName'],
          categoryImage: data['categoryImage'],
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  //Items in Catgory
  Future<void> itemsInCategory(String itemsCollection) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(itemsCollection).get();

      _categoryItems = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ItemModel(
          itemName: data['itemName'],
          itemPrice: data['itemPrice'],
          itemAvailability: data['itemAvailability'],
          itemImage: data['itemImage'],
          itemDescription: data['itemDescription']
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching items in category: $e");
    }
  }
}


