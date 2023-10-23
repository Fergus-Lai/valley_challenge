import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpException implements Exception {
  String code;
  SignUpException(this.code);
}

class SignupPage extends StatefulWidget {
  final Function() onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool submitted = false;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

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

  void setConfirmPasswordError(String? newError) {
    setState(() {
      confirmPasswordError = newError;
    });
  }

  bool disabled() {
    return passwordError != null ||
        emailError != null ||
        confirmPasswordError != null ||
        emailController.text == "" ||
        passwordController.text == "" ||
        confirmPasswordController.text == "" ||
        passwordController.text != confirmPasswordController.text;
  }

  Future<void> signUp() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        throw SignUpException("password-does-not-match");
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use:":
          setEmailError("Email Already In Use");
          break;
        case "invalid-email":
          setEmailError("Invalid Email");
          break;
        case "weak-password":
          setPasswordError("Password Too Weak");
          break;
      }
    } on SignUpException catch (e) {
      if (e.code == "password-does-not-match") {
        setConfirmPasswordError("Password Does Not Match");
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
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  onSubmitted: (input) {
                    if (input.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty &&
                        confirmPasswordController.text != input) {
                      setConfirmPasswordError("Password Does Not Match");
                    }
                    setState(() {}); // Empty Set State To Referesh
                  },
                  onTap: () {
                    setPasswordError(null);
                    setConfirmPasswordError(null);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Password"),
                    errorText: passwordError,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  onSubmitted: (input) {
                    if (input.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        passwordController.text != input) {
                      setConfirmPasswordError("Password Does Not Match");
                    }
                    setState(() {}); // Empty Set State To Referesh
                  },
                  onTap: () => setConfirmPasswordError(null),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Confirm Password"),
                    errorText: confirmPasswordError,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text("Create an Account")),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: disabled()
                          ? const MaterialStatePropertyAll(Colors.grey)
                          : const MaterialStatePropertyAll(Colors.purple),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: disabled() ? null : signUp,
                  child: const Text("Sign Up"),
                ),
              ],
            )));
  }
}
