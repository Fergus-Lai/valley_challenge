import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valley_challenge/components/color_button.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  const LoginPage({super.key, required this.onTap});

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
      } else if (e.code == 'wrong-password' ||
          e.code == "INVALID_LOGIN_CREDENTIALS") {
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      border: const OutlineInputBorder(),
                      label: const Text("Email"),
                      errorText: emailError),
                ),
                const SizedBox(height: 8),
                // Password Field
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  onSubmitted: (_) => setState(() {}),
                  onTap: () => setPasswordError(null),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Password"),
                    errorText: passwordError,
                  ),
                ),
                const SizedBox(height: 8),
                // Switch To Create Account Page
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text("Create an Account")),
                const SizedBox(height: 8),
                // Sign In Button
                ColorButton(
                    disabled: disabled(), onClick: signIn, text: "Sign In")
              ],
            )));
  }
}
