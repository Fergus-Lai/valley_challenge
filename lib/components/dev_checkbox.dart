import 'package:flutter/material.dart';

class DevCheckBox extends StatelessWidget {
  final bool developer;
  final Function(bool) onChanged;
  const DevCheckBox(
      {super.key, required this.developer, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Checkbox(value: developer, onChanged: (_) => onChanged(true)),
            const Text("Developer")
          ],
        ),
        Row(
          children: [
            Checkbox(value: !developer, onChanged: (_) => onChanged(false)),
            const Text("Founder")
          ],
        )
      ],
    ));
  }
}
