import "package:flutter/material.dart";
import 'package:valley_challenge/components/base_card.dart';
import 'package:valley_challenge/components/swipe_widget.dart';

class ProfileStack extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const ProfileStack({super.key, required this.data});

  @override
  State<ProfileStack> createState() => _ProfileStackState();
}

class _ProfileStackState extends State<ProfileStack> {
  List<Widget> profiles = [];
  @override
  void initState() {
    super.initState();
    final x = widget.data;
    x.shuffle();
    for (final profile in x) {
      if (profiles.isNotEmpty && (profiles.length % 9 == 0)) {
        profiles.add(SwipeWidget(
          onSlided: (like) async {
            await Future.delayed(const Duration(milliseconds: 200));
            setState(() {
              profiles.removeLast();
            });
          },
          name: "Ads",
          ads: true,
        ));
      }
      profiles.add(SwipeWidget(
        onSlided: (like) async {
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            profiles.removeLast();
          });
        },
        url: profile["image"],
        name: profile["name"],
      ));
    }
    profiles.add(BaseCard(
        child: Container(
            alignment: Alignment.center,
            color: Colors.red.shade900,
            child: const Text(
              "No More Cards Availalbe",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ))));
    profiles = profiles.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // Show Card
    return Stack(
      children: profiles,
    );
  }
}
