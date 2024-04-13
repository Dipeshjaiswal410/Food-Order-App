// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/views/item_views/item_detail_page.dart';
import 'package:food_ordering/views/item_views/item_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
    required this.categoriName,
  }) : super(key: key);

  final String categoriName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$categoriName Categories",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(categoriName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data to show!"),
            );
          }

          // Extract data from the snapshot
          var documents = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: documents.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              // Create an ItemModel from Firestore data
              ItemModel item = ItemModel(
                itemName: documents[index]['itemName'],
                itemPrice: documents[index]['itemPrice'],
                itemAvailability: documents[index]['itemAvailability'],
                itemImage: documents[index]['itemImage'],
                itemDescription: documents[index]['itemDescription'],
              );

              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailScreen(
                        itemsDetails: item,
                      ),
                    ),
                  );
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
                        SizedBox(
                          height: size.height / 7,
                          width: size.width / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.itemImage,
                              fit: BoxFit.fill,
                              errorBuilder: ((context, error, stackTrace) {
                                print("Error loading image: $error");
                                return const Text("Something");
                              }),
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
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}




/*
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
    required this.categoriName,
  }) : super(key: key);
  final String categoriName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("Rebuild**********");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$categoriName Categories",
          style: const TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          //ItemModel items = categoryItemProvider.categoryItems[index];
          return TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ItemDetailScreen()));
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
                    SizedBox(
                      height: size.height / 7,
                      width: size.width / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          //items.itemImage,
                          Pizza[index].itemImage,
                          fit: BoxFit.fill,
                          errorBuilder: ((context, error, stackTrace) {
                            print("Error loading image: $error");
                            return const Text("Something");
                          }),
                        ),
                      ),
                    ),
                    Text(
                      Pizza[index].itemName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "Price: USD",
                      style: TextStyle(
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
  }
}
*/