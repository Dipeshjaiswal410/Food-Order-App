// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/utils/toast_message.dart';
import 'package:food_ordering/views/item_views/item_detail_provider.dart';
import 'package:food_ordering/views/item_views/item_model.dart';
import 'package:food_ordering/views/place_order/place_order_screen.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({
    required this.itemsDetails,
    Key? key,
  }) : super(key: key);
  final ItemModel itemsDetails;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final itemdetailProv =
        Provider.of<ItemDetailProvider>(context, listen: false);
    print("Rebuild........");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemsDetails.itemName,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 2.7,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  itemsDetails.itemImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 5,
                    width: 70,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            //Item Name Portion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width / 3,
                  child: Text(
                    itemsDetails.itemName,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width / 2.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          itemdetailProv.decreaseQuantity();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: size.height / 20,
                            width: 40,
                            color: Colors.black87,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Consumer<ItemDetailProvider>(
                        builder: (context, value, child) {
                          return Text(
                            value.itemQuantity.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            itemdetailProv.increaseQuantity();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: size.height / 20,
                              width: 40,
                              color: Colors.black87,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),

            const Spacer(),
            //Description Part
            Expanded(
              flex: 10000,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  itemsDetails.itemDescription,
                ),
              ),
            ),
            const Spacer(),
            // Delivery Part
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Delivery Charge:  "),
                  Text(
                    "USD 2",
                    style: TextStyle(color: appColor),
                  ),
                  Spacer(),
                  Text("Delivery Time"),
                  SizedBox(
                    width: 0,
                  ),
                  Icon(
                    Icons.timer_rounded,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "30 min",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //const Spacer(),
            //Price Part
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          const LinearGradient(colors: [appColor, secondColor]),
                    ),
                    width: size.width / 3.5,
                    //color: Colors.black54,
                    child: Consumer<ItemDetailProvider>(
                      builder: (context, value, child) {
                        return TextButton(
                          onPressed: () {
                            itemdetailProv.addToCart(itemsDetails);
                            Utils.toastMessage(
                                value.cartMessage.toString(),
                                value.cartMessage == "Added to cart"
                                    ? appColor
                                    : errorColor);
                          },
                          child: const Icon(
                            Icons.trolley,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer<ItemDetailProvider>(
                    builder: (context, value, child) {
                      return Text(
                        "Total Price:\n\$${value.itemQuantity * itemsDetails.itemPrice}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: appColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          const LinearGradient(colors: [appColor, secondColor]),
                    ),
                    width: size.width / 3.5,
                    //color: Colors.black54,
                    child: Consumer<ItemDetailProvider>(
                      builder: (context, value, child) {
                        return TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlaceOrderScreen(
                                          itemName: itemsDetails.itemName,
                                          quantity: value.itemQuantity.toInt(),
                                          totalPrice:
                                              value.itemQuantity.toDouble() *
                                                  itemsDetails.itemPrice,
                                        )));
                          },
                          child: const Text(
                            "Place Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  /*Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          const LinearGradient(colors: [appColor, secondColor]),
                    ),
                    width: size.width / 3.5,
                    //color: Colors.black54,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Confirm?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  Column(
                                    children: [
                                      const Divider(),
                                      Text(
                                        "Item: ${itemsDetails.itemName}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Consumer<ItemDetailProvider>(
                                        builder: (context, value, child) {
                                          return Text(
                                            "Quantity: ${value.itemQuantity.toString()}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          );
                                        },
                                      ),
                                      Consumer<ItemDetailProvider>(
                                        builder: (context, value, child) {
                                          return Text(
                                            "Total Price:\$${value.itemQuantity * itemsDetails.itemPrice}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 79, 205, 84),
                                          radius: 40,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.check,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Utils.toastMessage(
                                                  "Order Placed Successfully!",
                                                  successColor);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
