import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valley_challenge/pages/app/app_page.dart';
import 'package:valley_challenge/pages/auth/login_signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance.authStateChanges(), // Keep Track on Auth State
      builder: (context, snapshot) {
        // Show App If User Signed In
        if (snapshot.hasData) {
          return const AppPage();
        } else {
          // Show Login Pages If Not Signed In
          return const LoginSignupPage();
        }
      },
    ));
  }
}
