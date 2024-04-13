import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/views/item_views/item_detail_page.dart';
import 'package:food_ordering/views/item_views/item_model.dart';

class Checkkk extends StatelessWidget {
  const Checkkk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Pizza").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // Extracting data from the snapshot
                  var documents = snapshot.data!.docs;

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: documents.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        // Create an ItemModel from Firestore data
                        ItemModel item = ItemModel(
                          itemName: documents[index]['itemName'],
                          itemPrice: documents[index]['itemPrice'],
                          itemAvailability: documents[index]
                              ['itemAvailability'],
                          itemImage: documents[index]['itemImage'],
                          itemDescription: documents[index]['itemDescription'],
                        );
                        return TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetailScreen(
                                          itemsDetails: ItemModel(
                                              itemName: '',
                                              itemPrice: 2,
                                              itemAvailability: true,
                                              itemImage: '',
                                              itemDescription: ''),
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 1,
                            shadowColor: appColor,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    //height: size.height / 7,
                                    child: ClipRRect(
                                      child: Image.network(
                                        item.itemImage,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item.itemName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Price: \$${item.itemPrice}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: appColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
    );
  }
}