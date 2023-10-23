import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final Function() onTap;
  SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text("Sign Up"),
        TextButton(
            onPressed: widget.onTap,
            child: const Text("Already Have an Account?"))
      ],
    ));
  }
}
