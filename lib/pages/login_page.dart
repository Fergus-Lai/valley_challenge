// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool submitted = false;
  String? emailError;
  String? passwordError;

  void setEmailError(String? newError) {
    setState(() {
      emailError = newError;
    });
  }

  void setPasswordError(String? newError) {
    setState(() {
      passwordError = newError;
    });
  }

  bool disabled() {
    return passwordError != null ||
        emailError != null ||
        emailController.text == "" ||
        passwordController.text == "";
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setEmailError("User Not Found");
      } else if (e.code == 'wrong-password') {
        setPasswordError("Incorrect Password");
      } else if (e.code == "invalid-email") {
        setEmailError("Invalid Email");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email Text Field
                TextField(
                  controller: emailController,
                  onSubmitted: (_) => setState(() {}),
                  onTap: () => setEmailError(null),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: const Text("Email"),
                      errorText: emailError),
                ),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  onSubmitted: (_) => setState(() {}),
                  onTap: () => setPasswordError(null),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: const Text("Password"),
                    errorText: passwordError,
                  ),
                ),
                SizedBox(height: 8),
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text("Create an Account")),
                SizedBox(height: 8),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: disabled()
                          ? MaterialStatePropertyAll(Colors.grey)
                          : MaterialStatePropertyAll(Colors.purple),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: disabled() ? null : signIn,
                  child: const Text("Sign In"),
                ),
              ],
            )));
  }
}
