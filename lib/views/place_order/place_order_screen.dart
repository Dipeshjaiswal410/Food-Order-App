// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';

import 'package:food_ordering/components/round_button.dart';
import 'package:food_ordering/utils/toast_message.dart';
import 'package:food_ordering/views/home_views/home_page.dart';
import 'package:food_ordering/views/place_order/place_order_provider.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    Key? key,
    required this.itemName,
    required this.quantity,
    required this.totalPrice,
  }) : super(key: key);
  final String itemName;
  final int quantity;
  final double totalPrice;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orderProvider =
        Provider.of<PlaceOrderProvider>(context, listen: false);

    print("Rebuild........");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter Name",
                  labelText: "Enter Name",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Phone Number",
                  labelText: "Phone Number",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: addressController,
                keyboardType: TextInputType.streetAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Address",
                  labelText: "Address",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                //controller: emailController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Item Name: ${widget.itemName}",
                  labelText: "Item Name: ${widget.itemName}",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                //controller: emailController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Quantity: ${widget.quantity.toString()}",
                  labelText: "Quantity: ${widget.quantity.toString()}",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                //controller: emailController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Total Price: ${widget.totalPrice.toString()}",
                  labelText: "Total Price: ${widget.totalPrice.toString()}",
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            RoundButton(
              title: "Place Order",
              onPress: () {
                if (addressController.text.isNotEmpty &&
                    phoneController.text.length == 10) {
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
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Consumer<PlaceOrderProvider>(
                                    builder: (context, value, child) {
                                      return CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 79, 205, 84),
                                        radius: 40,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.check,
                                            size: 50,
                                          ),
                                          onPressed: () {
                                            orderProvider.placeOrderFunction(
                                                nameController.text,
                                                phoneController.text,
                                                addressController.text,
                                                widget.itemName,
                                                widget.quantity.toString(),
                                                widget.totalPrice.toString());
                                            Navigator.pop(context);
                                            Utils.toastMessage(
                                                value.orderMessage.toString(),
                                                successColor);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      });
                } else if (phoneController.text.length != 10) {
                  Utils.toastMessage("Incorrect phone number", errorColor);
                } else {
                  Utils.toastMessage("Delivery details required!", errorColor);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
