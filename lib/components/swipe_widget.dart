import 'dart:math';

import 'package:flutter/material.dart';

import 'package:valley_challenge/components/swipe_card.dart';

class SwipeWidget extends StatefulWidget {
  final Future<void> Function(bool) onSlided;
  final String name;
  final String url;

  const SwipeWidget(
      {super.key,
      required this.onSlided,
      required this.url,
      required this.name});

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
      await likeAnimation(screenSize);
    } else if (position.dx.abs() > threshold) {
      await dislikeAnimation(screenSize);
    }
    reset();
  }

  void reset() {
    setState(() {
      dragging = false;
      position = Offset.zero;
      angle = 0;
    });
  }

  Future<void> likeAnimation(Size screenSize) async {
    setState(() {
      dragging = false;
      position += Offset(2 * screenSize.width, 0);
      angle = 20;
    });
    await widget.onSlided(true);
  }

  Future<void> dislikeAnimation(Size screenSize) async {
    setState(() {
      dragging = false;
      position += Offset(2 * -screenSize.width, 0);
      angle = -20;
    });
    await widget.onSlided(false);
  }

  Future<void> onClick(bool like, Size screenSize) async {
    if (like) {
      likeAnimation(screenSize);
    } else {
      dislikeAnimation(screenSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    late final size = MediaQuery.of(context).size;
    return GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: (details) => onDragUpdate(details, size),
        onHorizontalDragEnd: (details) => onDragEnd(details, size),
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
              child: SwipeCard(
                url: widget.url,
                name: widget.name,
                onClick: (like) => onClick(like, size),
              ));
        }));
  }
}
