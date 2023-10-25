import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:valley_challenge/pages/app/home_page.dart';
import 'package:valley_challenge/pages/app/profile_page.dart';

class NavPage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;
  const NavPage({super.key, required this.user});

  @override
  State<NavPage> createState() => NavPageState();
}

// Page for main app for user to naviage between profile and home using bottom nav bar

class NavPageState extends State<NavPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      HomePage(user: widget.user),
      ProfilePage(user: widget.user)
    ];
    return Scaffold(
        body: pages.elementAt(index),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Profile")
          ],
          currentIndex: index,
          onTap: (newIndex) => setState(() {
            index = newIndex;
          }),
        ));
  }
}
