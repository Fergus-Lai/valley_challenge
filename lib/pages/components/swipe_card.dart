import 'package:flutter/material.dart';

class SwipeCard extends StatelessWidget {
  final String url;
  const SwipeCard({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
              alignment: const Alignment(-0.3, 0))),
    );
  }
}
