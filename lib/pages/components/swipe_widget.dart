import 'dart:math';

import 'package:flutter/material.dart';

class SwipeWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function(bool) onSlided;

  const SwipeWidget({super.key, required this.child, required this.onSlided});

  @override
  State<SwipeWidget> createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> {
  Offset position = Offset.zero;
  bool dragging = false;
  final threshold = 100;
  double angle = 0;

  void onDragStart(DragStartDetails details) {
    setState(() {
      dragging = true;
    });
  }

  void onDragUpdate(DragUpdateDetails details, Size screenSize) {
    setState(() {
      position += details.delta;
      angle = 45 * position.dx / screenSize.width;
    });
  }

  Future<void> onDragEnd(DragEndDetails details, Size screenSize) async {
    if (position.dx > threshold) {
      setState(() {
        dragging = false;
        position += Offset(2 * screenSize.width, 0);
        angle = 20;
      });
      await widget.onSlided(true);
    } else if (position.dx.abs() > threshold) {
      setState(() {
        dragging = false;
        position += Offset(2 * -screenSize.width, 0);
        angle = -20;
      });
      await widget.onSlided(false);
    }
    setState(() {
      dragging = false;
      position = Offset.zero;
      angle = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: (details) =>
            onDragUpdate(details, MediaQuery.of(context).size),
        onHorizontalDragEnd: (details) =>
            onDragEnd(details, MediaQuery.of(context).size),
        child: LayoutBuilder(builder: (context, constraints) {
          final center = constraints.smallest.center(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle * pi / 180)
            ..translate(-center.dx, -center.dy);
          final animationDuration = dragging ? 0 : 400;
          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: animationDuration),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: widget.child);
        }));
  }
}
