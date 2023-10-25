import 'package:flutter/material.dart';
import 'package:valley_challenge/components/base_card.dart';
import 'package:valley_challenge/components/button_row.dart';
import 'package:valley_challenge/components/description_bar.dart';

class AdCard extends StatelessWidget {
  final Future<void> Function(bool) onClick;
  const AdCard({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.purple,
          child: DescriptionBar(onClick: onClick, text: "Ads")),
    );
  }
}
