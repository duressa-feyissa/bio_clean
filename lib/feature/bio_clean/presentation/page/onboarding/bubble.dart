import 'dart:math';

import 'package:flutter/material.dart';

class Bubble {
  late Offset position;
  late double radius;
  late double speedX;
  late double speedY;

  Bubble({
    required this.position,
    required this.radius,
    required this.speedX,
    required this.speedY,
  });
}

class BubbleScreen extends StatefulWidget {
  const BubbleScreen(
      {super.key,
      required this.color,

      required this.numberOfBubbles,
      required this.maxBubbleSize});

  final Color color;
  final int numberOfBubbles;

  final double maxBubbleSize;

  @override
  State<StatefulWidget> createState() {
    return _BubbleScreenState();
  }
}

class _BubbleScreenState extends State<BubbleScreen>
    with TickerProviderStateMixin {
  late List<Bubble> bubbles;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    bubbles = createBubbles(widget.numberOfBubbles, widget.maxBubbleSize);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 16))
      ..addListener(() {
        moveBubbles(MediaQuery.of(context).size.width.toInt(),
            MediaQuery.of(context).size.height.toInt());
        setState(() {});
      })
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(bubbles: bubbles, color: widget.color),
      child: Container(),
    );
  }

  List<Bubble> createBubbles(int numberOfBubbles, double maxBubbleSize) {
    final List<Bubble> bubbles = [];

    for (int i = 0; i < numberOfBubbles; i++) {
      double bubbleSize = Random().nextDouble() * maxBubbleSize + 10.0;
      bubbles.add(Bubble(
        position:
            Offset(Random().nextDouble() * 400, Random().nextDouble() * 800),
        radius: bubbleSize,
        speedX: (Random().nextDouble() * 2 - 1) * 0.3,
        speedY: (Random().nextDouble() * 2 - 1) * 0.3,
      ));
    }

    return bubbles;
  }

  void moveBubbles(int width, int height) {
    for (var bubble in bubbles) {
      bubble.position += Offset(bubble.speedX, bubble.speedY);

      if (bubble.position.dx < 0) {
        bubble.position = Offset(400, bubble.position.dy);
      } else if (bubble.position.dx > 400) {
        bubble.position = Offset(0, bubble.position.dy);
      }

      if (bubble.position.dy < 0) {
        bubble.position = Offset(bubble.position.dx, 800);
      } else if (bubble.position.dy > 800) {
        bubble.position = Offset(bubble.position.dx, 0);
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final Color color;

  BubblePainter({required this.bubbles, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    for (var bubble in bubbles) {
      canvas.drawCircle(bubble.position, bubble.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}