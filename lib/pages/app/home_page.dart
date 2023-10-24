import 'package:flutter/material.dart';
import 'package:valley_challenge/pages/components/swipe_card.dart';
import 'package:valley_challenge/pages/components/swipe_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: SwipeWidget(
            child: const SwipeCard(),
            onSlided: (t) => {},
          ),
        ),
      ),
    );
  }
}
