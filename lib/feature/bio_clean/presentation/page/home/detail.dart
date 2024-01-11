import 'dart:math' as math;

import 'package:bio_clean/feature/bio_clean/presentation/page/home/history.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isCommentVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(1, 127, 97, 0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(
              children: [
                const BubbleScreen(
                    color: Color.fromARGB(31, 144, 201, 166),
                    numberOfBubbles: 3,
                    maxBubbleSize: 90),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCommentVisible = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Color.fromRGBO(1, 127, 97, 1),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      'Machine',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 20,
                                        color: Color.fromRGBO(1, 127, 97, 1),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Kano',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(1, 127, 97, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCommentVisible = !isCommentVisible;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromRGBO(1, 127, 97, 1),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        const DoubleCircularTimerWidget(
                          waterProgress: 0.6,
                          biogasProgress: 0.4,
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const History()));
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                1, 127, 97, 1),
                                          ),
                                          child: const Icon(
                                            Icons.history_outlined,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Machine Name',
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'S/N: 1234567890',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Water Added: 10L',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Water Type: Food Waste',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Waste Added: 10Kg',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Mechanic Added: 10Kg',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Start Production: 10/10/2021',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'End Production: 10/10/2021',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Estimated Biogas Production: 10L',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Estimated Water Production: 10L',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Current Biogas Production: 8L',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Current Water Production: 8L',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (isCommentVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCommentVisible = !isCommentVisible;
                                  });
                                },
                                child: const Image(
                                  image: AssetImage('assets/logo.png'),
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hey, I'm Bio Clean. I'm here to help you manage your waste.",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Waste Type',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Waste Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Water Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Mechanic Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 55),
                              backgroundColor:
                                  const Color.fromRGBO(1, 127, 97, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('Add New Waste',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: CircularTimer(
                      type: 'biogas',
                      progress: widget.waterProgress,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(160, 233, 216, 1),
                          Color.fromRGBO(1, 127, 97, 1),
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
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.365,
                height: MediaQuery.of(context).size.width * 0.365,
                child: CircularTimer(
                  type: 'water',
                  progress: widget.biogasProgress,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(219, 226, 226, 1),
                      Color.fromRGBO(57, 121, 126, 1),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(57, 121, 126, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$progressString%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(57, 121, 126, 1),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(57, 121, 126, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$progressString%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(57, 121, 126, 1),
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
