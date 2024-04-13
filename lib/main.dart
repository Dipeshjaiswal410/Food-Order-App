import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_ordering/views/category_views/category_provider.dart';
import 'package:food_ordering/views/home_views/home_page.dart';
import 'package:food_ordering/views/item_views/item_detail_provider.dart';
import 'package:food_ordering/views/logIn_views/login_page.dart';
import 'package:food_ordering/views/logIn_views/login_provider.dart';
import 'package:food_ordering/views/logOut_function/logout_provider.dart';
import 'package:food_ordering/views/place_order/place_order_provider.dart';
import 'package:food_ordering/views/signUp_views/signup_provider.dart';
import 'package:food_ordering/views/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(), //Login Provider
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(), //Sign Up Provider
        ),
        ChangeNotifierProvider<TimerProvider>(
          create: (context) => TimerProvider(),
        ), //Timer Provider

        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ), //Category Provider
        ChangeNotifierProvider<ItemDetailProvider>(
          create: (context) => ItemDetailProvider(),
        ), //Item Detail Provider

        ChangeNotifierProvider<LogOutProvider>(
          create: (context) => LogOutProvider(),
        ), //Logout Provider
        ChangeNotifierProvider<PlaceOrderProvider>(
            create: (context) => PlaceOrderProvider()), //Place Order Provider
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        //home: LoginScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? loginData;
  bool? newUser;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      loginData = await SharedPreferences.getInstance();
      newUser = (loginData!.getBool('login') ?? true);

      if (newUser == false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width / 3,
              width: size.width / 3,
              child: Image.asset(
                'assets/images/logo.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
