import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ViewClock extends StatefulWidget {
  final double size;
  const ViewClock({super.key, required this.size});

  @override
  State<ViewClock> createState() => _ViewClockState();
}

class _ViewClockState extends State<ViewClock> {
  @override
  void initState() {
    // TODO: implement initState
    
    Timer.periodic(
       const Duration(seconds: 1),
      (timer) {
        setState(
          () {},
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var datetime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var xCenter = size.width / 2;
    var yCenter = size.height / 2;
    var clkCenter = Offset(xCenter, yCenter);
    var clkRadius = min(xCenter, yCenter);
    // clock background
    var fillBrush = Paint()..color = const Color(0xFF444974);

    //clock outline
    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/20;

    //clock centre color
    var insideFillBrush = Paint()..color = const Color(0xFFEAECFF);

    //second hand
    var secondBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/60;

    var xSec = xCenter + clkRadius* 0.6 * cos(datetime.second * 6 * pi / 180);
    var ySec = xCenter + clkRadius* 0.6 * sin(datetime.second * 6 * pi / 180);

    //minute hand
    var minuteBrush = Paint()
      ..shader = const RadialGradient(
              colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: clkCenter, radius: clkRadius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/30;

    var xMin = xCenter + clkRadius* 0.6 * cos(datetime.minute * 6 * pi / 180);
    var yMin = xCenter + clkRadius* 0.6 * sin(datetime.minute * 6 * pi / 180);

    //hour hand
    var hourBrush = Paint()
      ..shader = const RadialGradient(
              colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: clkCenter, radius: clkRadius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;

    var xHour = xCenter +
        clkRadius* 0.4 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var yHour = xCenter +
        clkRadius* 0.4 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);

    

    //drawing
    canvas.drawCircle(clkCenter, clkRadius * 0.75, fillBrush);
    canvas.drawCircle(clkCenter, clkRadius * 0.75, outlineBrush);
    canvas.drawLine(clkCenter, Offset(xHour, yHour), hourBrush);
    canvas.drawLine(clkCenter, Offset(xMin, yMin), minuteBrush);
    canvas.drawLine(clkCenter, Offset(xSec, ySec), secondBrush);
    
    canvas.drawCircle(clkCenter, clkRadius * 0.12, insideFillBrush);

    //outer circle
    var drawLine = Paint()
    ..color=const Color(0xFFEAECFF)
    ..strokeWidth=2;
    var outCircleRad=clkRadius;
    var incircleRad=clkRadius * 0.9;
    for(double i=0;i<=360;i+=30){
      var x1=xCenter + outCircleRad * cos(i * pi/180);
      var y1=xCenter + outCircleRad * sin(i * pi/180);

      var x2=xCenter + incircleRad * cos(i * pi/180);
      var y2=xCenter + incircleRad * sin(i * pi/180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), drawLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
