import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text("Login"),
        TextButton(
            onPressed: widget.onTap, child: const Text("Create an Account"))
      ],
    ));
  }
}
