import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/components/round_button.dart';
import 'package:food_ordering/utils/toast_message.dart';
import 'package:food_ordering/views/home_views/home_page.dart';
import 'package:food_ordering/views/logIn_views/login_provider.dart';
import 'package:food_ordering/views/signUp_views/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late SharedPreferences loginData;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final loginprovider = Provider.of<LoginProvider>(context, listen: false);
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
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
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
                child: Consumer<LoginProvider>(
                  builder: (context, value, child) {
                    return TextField(
                      obscureText: value.passwordVisibility,
                      controller: passwordController,
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
                          icon: Consumer<LoginProvider>(
                            builder: (context, value, child) {
                              return value.passwordVisibility == true
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off);
                            },
                          ),
                          onPressed: () {
                            loginprovider.changePasswordVisibility();
                          },
                        ),
                        counterText: "",
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              RoundButton(
                  title: "Login",
                  onPress: () async {
                    //Login to firebase
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      Utils.toastMessage("Login successfully", successColor);

                      //Shared Preferences
                      loginData.setBool("login", false);
                      String gmailId = emailController.text;
                      loginData.setString("gmailId", gmailId);

                      //Navigating to next
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } on FirebaseAuthException catch (e) {
                      Utils.toastMessage(e.toString(), errorColor);
                    }
                  }),
              SizedBox(
                height: size.height / 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: const Text(
                    "Don't have account? SignUp",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
