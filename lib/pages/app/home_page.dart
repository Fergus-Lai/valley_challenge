import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:valley_challenge/components/profile_stack.dart';

class HomePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final cardReference = FirebaseFirestore.instance
      .collection(widget.user.data()!["role"] + "_cards");

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
              future: cardReference.get(), // Get Cards
              builder: (context, snapshot) {
                // Show Cards If Loaded
                if (snapshot.hasData) {
                  return ProfileStack(
                      data: snapshot.data!.docs
                          .map((doc) => doc.data())
                          .toList());
                } else {
                  // Show Loading Indicator
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
