import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/components/round_button.dart';
import 'package:food_ordering/utils/toast_message.dart';
import 'package:food_ordering/views/home_views/home_page.dart';
import 'package:food_ordering/views/signUp_views/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  late SharedPreferences loginData;

  //final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    loginData = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final signupprovider = Provider.of<SignUpProvider>(context, listen: false);
    print("Build******");
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.elliptical(500, 200),
                ),
                color: appColor,
                child: SizedBox(
                  height: size.height / 2.8,
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 10,
                      ),
                      const Center(
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "Full Name",
                    labelText: "Full Name",
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
                  keyboardType: TextInputType.emailAddress,
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "Email",
                    labelText: "Email",
                    counterText: "",
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Consumer<SignUpProvider>(
                  builder: (context, value, child) {
                    return TextField(
                      obscureText: value.passwordVisibility,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hoverColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: "Password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Consumer<SignUpProvider>(
                            builder: (context, value, child) {
                              return value.passwordVisibility == true
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off);
                            },
                          ),
                          onPressed: () async {
                            signupprovider.changePasswordVisibility();
                          },
                        ),
                        counterText: "",
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Consumer<SignUpProvider>(
                builder: ((context, value, child) {
                  return RoundButton(
                      title: "Signup",
                      onPress: () async {
                        signupprovider.signUpFuntion(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            phoneController.text,
                            addressController.text);
                        if (value.signupMessage == "SignUp Successfully") {
                          Utils.toastMessage(
                              "SignUp Successfully", successColor);

                          //Shared Preferences
                          loginData.setBool("login", true);
                          String gmailId = emailController.text;
                          loginData.setString("gmailId", gmailId);

                          //Navigating to next page
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          Utils.toastMessage(value.signupMessage, errorColor);
                          Navigator.pop(context);
                        }
                      });
                }),
              ),

              //Creating user.....
              /*try {
                    await _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Utils.toastMessage("Signup successfylly", successColor);

                    //Navigating to the Home Page
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  } on FirebaseAuthException catch (e) {
                    Utils.toastMessage(e.toString(), errorColor);
                  }*/

              SizedBox(
                height: size.height / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
