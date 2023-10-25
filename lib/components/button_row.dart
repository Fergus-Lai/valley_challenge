import "package:flutter/material.dart";

class ButtonRow extends StatelessWidget {
  final Future<void> Function(bool) onClick;
  const ButtonRow({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton.filled(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () => onClick(false),
            icon: Icon(Icons.close, color: Colors.red.shade900)),
        IconButton.filled(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () => onClick(true),
            icon: Icon(Icons.favorite, color: Colors.green.shade400))
      ],
    );
  }
}
