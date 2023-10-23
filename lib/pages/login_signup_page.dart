import 'package:flutter/material.dart';
import 'package:valley_challenge/pages/login_page.dart';
import 'package:valley_challenge/pages/signup_page.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => LoginSignupPageState();
}

class LoginSignupPageState extends State<LoginSignupPage> {
  bool displayLogin = true;

  void togglePage() {
    setState(() {
      displayLogin = !displayLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (displayLogin) {
      return LoginPage(onTap: togglePage);
    } else {
      return SignupPage(onTap: togglePage);
    }
  }
}
