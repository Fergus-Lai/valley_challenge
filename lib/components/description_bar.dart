import "package:flutter/material.dart";
import "package:valley_challenge/components/button_row.dart";

class DescriptionBar extends StatelessWidget {
  final String text;
  final Future<void> Function(bool) onClick;
  const DescriptionBar({super.key, this.text = "", required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              ButtonRow(onClick: onClick)
            ],
          ),
        ),
      ),
    );
  }
}
