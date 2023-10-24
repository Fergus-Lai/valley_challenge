import "package:flutter/material.dart";
import "package:valley_challenge/pages/components/profile_card.dart";

class ProfileStack extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const ProfileStack({super.key, required this.data});

  @override
  State<ProfileStack> createState() => _ProfileStackState();
}

class _ProfileStackState extends State<ProfileStack> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profiles = widget.data;
    return Stack(
      children: profiles
          .map((profile) => ProfileCard(
              onSlided: (direction) async {
                await Future.delayed(const Duration(milliseconds: 200));
                setState(() {
                  profiles.removeLast();
                });
              },
              isFront: widget.data.last["image"] ==
                  profile["image"], // FLutter Display Last First
              url: profile["image"]))
          .toList(),
    );
  }
}
