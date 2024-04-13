import 'package:flutter/material.dart';
import 'package:food_ordering/utils/routes/routes_name.dart';
import 'package:food_ordering/views/cart%20view/cart_page.dart';
import 'package:food_ordering/views/logIn_views/login_page.dart';
import 'package:food_ordering/views/signUp_views/signup_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case RoutesName.cart:
        return MaterialPageRoute(builder: (context) =>  CartScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined."),
            ),
          );
        });
    }
  }
}
