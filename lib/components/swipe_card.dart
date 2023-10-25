import 'package:flutter/material.dart';
import 'package:valley_challenge/components/base_card.dart';
import 'package:valley_challenge/components/description_bar.dart';

class SwipeCard extends StatelessWidget {
  final String url;
  final String name;
  final Future<void> Function(bool) onClick;
  const SwipeCard(
      {super.key,
      required this.url,
      required this.name,
      required this.onClick});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                  alignment: const Alignment(-0.3, 0))),
          child: DescriptionBar(onClick: onClick, text: name)),
    );
  }
}
