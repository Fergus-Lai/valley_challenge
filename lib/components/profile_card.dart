import 'package:flutter/material.dart';

import "package:valley_challenge/pages/components/swipe_card.dart";
import "package:valley_challenge/pages/components/swipe_widget.dart";

class ProfileCard extends StatelessWidget {
  final bool isFront;
  final String url;
  final String name;
  final Future<void> Function(bool) onSlided;
  const ProfileCard(
      {super.key,
      required this.isFront,
      required this.url,
      required this.name,
      required this.onSlided});

  @override
  Widget build(BuildContext context) {
    return isFront
        ? SwipeWidget(
            onSlided: onSlided,
            url: url,
            name: name,
          )
        : SwipeCard(
            url: url,
            name: name,
            onClick: (_) async {},
          );
  }
}
