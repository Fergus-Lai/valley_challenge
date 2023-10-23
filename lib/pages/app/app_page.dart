import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valley_challenge/pages/app/data_page.dart';
import 'package:valley_challenge/pages/app/nav_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(
    BuildContext context,
  ) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            return NavPage(user: snapshot.data!);
          } else {
            return const DataPage();
          }
        });
  }
}
