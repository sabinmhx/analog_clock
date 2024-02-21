import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ANALOG CLOCK"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: const Center(
          child: AnalogClock(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnalogClock extends StatefulWidget {
  const AnalogClock({super.key});

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  /// To create a new repeating timer
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1),
        update); // New repeating timer with which takes duration and a callback function as its parameters
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2, // Transforms clock anticlockwise by 90 degrees
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }

  void update(Timer timer) {
    // Callback function passed to Timer.periodic() for updating state
    setState(() {});
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    /// Main circle for analog clock
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..strokeWidth = 7.0
          ..style = PaintingStyle.fill
          ..color = Colors.lightBlue);

    /// Outer circle for showing border of clock
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..strokeWidth = 7.0
          ..style = PaintingStyle.stroke);

    /// Center Dot for clock
    canvas.drawCircle(
        center,
        radius - 140,
        Paint()
          ..strokeWidth = 3.0
          ..style = PaintingStyle.fill);

    /// Current time divided into hour, minute and second to draw its respective hands in analog clock
    final hour = DateTime.now().hour;
    final minute = DateTime.now().minute;
    final second = DateTime.now().second;

    /// Hour hand of clock
    canvas.drawLine(
      center,
      center +
          Offset((radius - 80) * cos((hour * 30 + minute * 0.5) * pi / 180),
              (radius - 80) * sin((hour * 30 + minute * 0.5) * pi / 180)),
      Paint()..strokeWidth = 6.0,
    );

    /// Minute Hand of Clock
    canvas.drawLine(
      center,
      center +
          Offset((radius - 45) * cos(minute * 6 * pi / 180),
              (radius - 45) * sin(minute * 6 * pi / 180)), //
      Paint()..strokeWidth = 4.0,
    );

    /// Second Hand of clock
    canvas.drawLine(
      center,
      center +
          Offset((radius - 50) * cos(second * 6 * pi / 180),
              (radius - 50) * sin(second * 6 * pi / 180)),
      Paint()..strokeWidth = 2.0,
    );

    /// 12 ticks for the clock
    for (int i = 0; i < 12; i++) {
      canvas.drawLine(
          center +
              Offset(cos(pi / 6 * i) * (radius - 15),
                  sin(pi / 6 * i) * (radius - 15)),
          center + Offset(cos(pi / 6 * i) * radius, sin(pi / 6 * i) * radius),
          Paint()..strokeWidth = 4.0);
    }
  }

  /// Compares old instance with new instance; returns true if it detects changes
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
