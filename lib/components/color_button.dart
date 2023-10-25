import "package:flutter/material.dart";

class ColorButton extends StatelessWidget {
  final bool disabled;
  final Future<void> Function() onClick;
  final String text;

  const ColorButton(
      {super.key,
      required this.disabled,
      required this.onClick,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: disabled
                ? const MaterialStatePropertyAll(Colors.grey)
                : const MaterialStatePropertyAll(Colors.purple),
            foregroundColor: const MaterialStatePropertyAll(Colors.white)),
        onPressed: disabled ? null : onClick,
        child: Center(
          child: (Text(text)),
        ));
  }
}
