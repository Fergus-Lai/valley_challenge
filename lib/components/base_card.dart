import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  const BaseCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child:
            ClipRRect(borderRadius: BorderRadius.circular(20), child: child));
  }
}
