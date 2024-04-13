import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/views/item_views/item_detail_page.dart';
import 'package:food_ordering/views/item_views/item_model.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "My Cart",
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        )),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("UserCart")
                .doc(_auth.currentUser?.email)
                .collection("cartItem")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No data to show!"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Extracting data from the snapshot
              var documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  // Create an ItemModel from Firestore data
                  ItemModel item = ItemModel(
                    itemName: documents[index]['itemName'],
                    itemPrice: documents[index]['itemPrice'],
                    itemAvailability: documents[index]['itemAvailability'],
                    itemImage: documents[index]['itemImage'],
                    itemDescription: documents[index]['itemDescription'],
                  );
                  return Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDetailScreen(
                                      itemsDetails: ItemModel(
                                          itemName: item.itemName,
                                          itemPrice: item.itemPrice,
                                          itemAvailability:
                                              item.itemAvailability,
                                          itemImage: item.itemImage,
                                          itemDescription:
                                              item.itemDescription),
                                    )));
                      },
                      child: SizedBox(
                        height: size.height / 5.5,
                        width: size.width,
                        child: Card(
                          shadowColor: appColor,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.5,
                                color: appColor,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                height: size.height / 5,
                                width: size.height / 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(item.itemImage,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Column(
                                children: [
                                  const Spacer(),
                                  Expanded(
                                    child: Text(
                                      item.itemName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Text(
                                    "Price: \$${item.itemPrice}",
                                    style: const TextStyle(
                                        color: appColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
