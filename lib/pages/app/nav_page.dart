import 'package:flutter/material.dart';
import 'package:valley_challenge/pages/app/home_page.dart';
import 'package:valley_challenge/pages/app/profile_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => NavPageState();
}

class NavPageState extends State<NavPage> {
  static const List<Widget> _pages = <Widget>[HomePage(), ProfilePage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages.elementAt(index),
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
