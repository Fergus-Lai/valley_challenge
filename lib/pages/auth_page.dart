import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  bool authed = true;

  @override
  Widget build(BuildContext context) {
    return authed
        ? const Scaffold(body: (Text("Auth Page")))
        : const Scaffold(body: (Text("Unauthed")));
  }
}
