import 'package:ecom/main.dart';
import 'package:ecom/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:ecom/screens/home.dart';
import 'package:ecom/screens/login.dart';
import 'package:ecom/screens/registre.dart';

class AppRoutes {
  static const String splash = '/splash'; // Add this line
  static const String login = '/login';
  static const String home = '/home';
  static const String registre = '/registre';
  static const String profile = '/profile';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash3());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case registre:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      
      default:
        return MaterialPageRoute(builder: (_) => const SignupPage  ());
    }
  }
}
