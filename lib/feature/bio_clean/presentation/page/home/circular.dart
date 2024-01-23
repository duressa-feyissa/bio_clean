import 'dart:math' as math;

import 'package:flutter/material.dart';

class DoubleCircularTimerWidget extends StatefulWidget {
  const DoubleCircularTimerWidget({
    required this.waterProgress,
    required this.biogasProgress,
    Key? key,
  }) : super(key: key);

  final double waterProgress;
  final double biogasProgress;

  @override
  State<DoubleCircularTimerWidget> createState() =>
      _DoubleCircularTimerWidgetState();
}

class _DoubleCircularTimerWidgetState extends State<DoubleCircularTimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: CircularTimer(
                      type: 'biogas',
                      progress: widget.waterProgress,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(160, 233, 216, 1),
                          Color.fromRGBO(9, 182, 141, 1),
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      progressColor: const Color.fromRGBO(67, 57, 126, 1),
                      strokeWidth: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.467,
                height: MediaQuery.of(context).size.width * 0.467,
                child: CircularTimer(
                  type: 'water',
                  progress: widget.biogasProgress,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(195, 230, 233, 1),
                      Color.fromRGBO(42, 223, 236, 1),
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  progressColor: const Color.fromRGBO(1, 127, 97, 1),
                  strokeWidth: 25.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularTimer extends StatelessWidget {
  final double progress;
  final Gradient gradient;
  final Color progressColor;
  final double strokeWidth;
  final String type;

  const CircularTimer({
    super.key,
    required this.type,
    required this.progress,
    required this.gradient,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final String progressString = (progress * 100).toStringAsFixed(0);
    return CustomPaint(
      painter: CircularTimerPainter(
        type: type,
        progress: progress,
        gradient: gradient,
        progressColor: progressColor,
        strokeWidth: strokeWidth,
      ),
      child: Center(
        child: type == 'water'
            ? Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Water:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(42, 223, 236, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$progressString%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(42, 223, 236, 1),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Biogas:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(9, 182, 141, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$progressString%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(9, 182, 141, 1),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class CircularTimerPainter extends CustomPainter {
  final String type;
  final double progress;
  final Gradient gradient;
  final Color progressColor;
  final double strokeWidth;

  CircularTimerPainter({
    required this.type,
    required this.progress,
    required this.gradient,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.0;

    final Paint backgroundPaint = Paint()
      ..color = type == 'biogas'
          ? const Color.fromARGB(255, 139, 140, 168).withOpacity(0.2)
          : const Color.fromARGB(255, 169, 169, 185).withOpacity(0.2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint fillPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
