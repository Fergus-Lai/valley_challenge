import 'dart:math';

import 'package:flutter/material.dart';
import 'package:valley_challenge/components/ad_card.dart';
import 'package:valley_challenge/components/swipe_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SwipeWidget extends StatefulWidget {
  final Future<void> Function(bool) onSlided;
  final String name;
  final String url;
  final bool ads;

  const SwipeWidget(
      {super.key,
      required this.onSlided,
      this.url = "",
      required this.name,
      this.ads = false});

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
      // Calculate Positon of Card
      position += details.delta;
      angle = 45 * position.dx / screenSize.width;
    });
  }

  Future<void> onDragEnd(DragEndDetails details, Size screenSize) async {
    // If it passes threshold to the right (Like)
    if (position.dx > threshold) {
      await likeAnimation(screenSize);
      // If it passes threshold to the left (Dislike)
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
    Fluttertoast.cancel();
    setState(() {
      dragging = false;
      position += Offset(2 * screenSize.width, 0);
      angle = 20;
    });
    Fluttertoast.showToast(
        msg: "Liked",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    await widget.onSlided(true);
  }

  Future<void> dislikeAnimation(Size screenSize) async {
    setState(() {
      dragging = false;
      position += Offset(2 * -screenSize.width, 0);
      angle = -20;
    });
    Fluttertoast.showToast(
        msg: "Disliked",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    await widget.onSlided(false);
  }

  Future<void> onClick(bool like, Size screenSize) async {
    Fluttertoast.cancel();
    await Future.delayed(const Duration(milliseconds: 200));
    if (like) {
      likeAnimation(screenSize);
    } else {
      dislikeAnimation(screenSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Query Size of Screen
    late final size = MediaQuery.of(context).size;
    return GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: (details) => onDragUpdate(details, size),
        onHorizontalDragEnd: (details) => onDragEnd(details, size),
        child: LayoutBuilder(builder: (context, constraints) {
          final center = constraints.smallest.center(Offset.zero);
          // Rotate Matrix From The Center
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle * pi / 180)
            ..translate(-center.dx, -center.dy);
          // Disable Animation if Dragging
          final animationDuration = dragging ? 0 : 400;
          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: animationDuration),
              // Translate Card Based On The Position
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: widget.ads
                  ? AdCard(onClick: (like) => onClick(like, size))
                  : SwipeCard(
                      url: widget.url,
                      name: widget.name,
                      onClick: (like) => onClick(like, size),
                    ));
        }));
  }
}
